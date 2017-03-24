Then(/^comment form should (not) be displayed/) do |negation|
  steps %(
    Then page should #{'not' if negation} contain button 'Отправить'
    Then page should #{'not' if negation} contain field 'comment[content]'
    Then page should #{'not' if negation} contain css '#new-post-form'
  )
end

Given(/^([^']*)'s comment '([^']*)' on ([^']*)'s post '([^']*)'/) do |c_author, c, p_author, p|
  post_author = User.find_by name: p_author
  post = Post.find_by title: p, user: post_author
  comment_author = User.find_by name: c_author
  post.comments.create content: c, user: comment_author
end

When(/^i'm on edit page of comment '([^']*)' on ([^']*)'s post '([^']*)'/) do |c, u, t|
  user = User.find_by name: u
  post = Post.find_by title: t, user: user
  comment = post.comments.find_by content: c

  visit comment_path(post, comment)
end

When(/^i'm on ([^']*)'s show post page '([^']*)'/) do |username, title|
  user = User.find_by name: username
  post = Post.find_by title: title

  visit "/id#{user.id}/posts/#{post.id}"
end
