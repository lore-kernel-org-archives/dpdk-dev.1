Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA712EF8FF4
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:17:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACD4A40A6B;
	Wed,  4 Mar 2026 16:17:05 +0100 (CET)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 0A5974067B
 for <dev@dpdk.org>; Wed,  4 Mar 2026 16:17:05 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 573837A01C1;
 Wed,  4 Mar 2026 10:17:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 04 Mar 2026 10:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1772637424; x=1772723824; bh=hrLvh6nYdg
 1gkSrwRaSeSc8T+LYwHRJFqmBAOAzmxI4=; b=MmVOsVXUT4XFf18s95E6Xsmjj5
 BDAlI34wGi6d88iWt1X/nuAP5j4SGjfqPAeu3hG1fHybJhzDqs1kDFdbQe9FsQTu
 DHZ+4gBxJxnkpFnkUS4hjuIo2M2BGRdB7fTm50byqs5ocQCWwPKrzvNT5hFoY6IY
 JbEOtgJDrOoLJuyUYS3e1GrCcLrUpRvIL+9YoPfXuv6GYPYrsKtQFJTsdWpqTwzr
 KXqnTMcyjL+bjxbhRs2/5jdS9NdDZv8d+umSYOt3S2oF5kEZ1XjXWs7MjB1bM7PN
 Wj0BhAuvJyWk6nGLBzmvFF63BR2a59SYAEGqkO60elUI/SZwFviOgjSaqHbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1772637424; x=1772723824; bh=hrLvh6nYdg1gkSrwRaSeSc8T+LYwHRJFqmB
 AOAzmxI4=; b=hsddgPNxOxOpHuiGyEywKE9f34T10fpwgod2o1uvjJTtwqEobmQ
 zEFM2nCZZ2fMAA/ajRAaxTeINs7CLrXHOwTWraG4flas845TS7+PXShKZ3dP7Z7P
 Uj7DG2iyY7igSNIqPyoV42ZPFF6eCUo3ekMS+tgHxvgLGvJ7aHecH8XGKrrvgYhC
 s3TZKjaoFnHiDF+L06Iw/fkcdqZXX0GZoKnJwbTZkQHDjnZ4yNo3Ek/YcdGx627T
 IjNKYFICK4+jPFhQE4RUZ356y2H9MUfnHsQbLj04KywfNbfACv6rNteovDnb+1ie
 K6PyeH/lKatJ5UY8LKdWr9/W3EosyFZ9zVA==
X-ME-Sender: <xms:70yoac7LF8F6RDPTCHFGyTOMwaTWGikq0zJZh-ZhokU8p0ly_jsEGA>
 <xme:70yoaTxswpBlc2199z-QnTvvj422jMi-F9ma0Xi0qjRyie2lUgHKX80Ur93XOygoQ
 QCm3HMZsmdV6lbgd4RRYYRO5ywEqdVoYQeS3C8is4H85RL_8cCDQw>
X-ME-Received: <xmr:70yoaWjKBijxg8O-lOXCywfZ-5FmfUuuiMcFhWCDI_5idAEs6Vay962oIorkbHooX7_HNMshFzZxghhF2wO9NifcFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieefkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkggfgtgesthhqredttddtje
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpefhteeulefhheevudetvdeuleehie
 evudetheehveevtdfguefffffgfefftdfgleenucffohhmrghinheplhhinhhugihfohhu
 nhgurghtihhonhdrohhrghdpughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgv
 thdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
 gvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:70yoad-yPZO5oYBxKDTO-hwHRZBWD5oQRrNA7pDBjef8hgmgqOgGyQ>
 <xmx:70yoaTvur-PIZ-W8mIkYHeEO5kY3Z56m-bvudXs9xfXFWrhdloHS_w>
 <xmx:70yoaUbyyjK00XMHYqwxqMo4e6E9HH-VavZxBdQkyyLWdFVRO9pxkA>
 <xmx:70yoaToBwaPzdL1gSOXpAPErQiCIAzz_UR7QDChvD6acISKKtVu3jg>
 <xmx:8EyoaZrzEXh5qah2yac8WfahoRKmi-6OID4T2OlxK7JVlk0fWRlGWahY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Wed, 4 Mar 2026 10:17:03 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Minutes of DPDK Technical Board Meeting, 2026-02-18
Date: Wed, 04 Mar 2026 16:17:01 +0100
Message-ID: <4728809.Us1k9K0G1Y@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Members Attending: 8/10
        - Aaron Conole
        - Bruce Richardson
        - Kevin Traynor
        - Konstantin Ananyev
        - Maxime Coquelin
        - Morten Br=C3=B8rup
        - Stephen Hemminger
        - Thomas Monjalon (Chair)

NOTE: The Technical Board meetings take place every second Wednesday at 3 p=
m UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?passwo=
rd=3Dd808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on March 4 and will be chaired by Aaron Conole.


1/ Summit CFP status

Decided to extend for one more week (until March 1).


2/ Reviewer / Contributor campaign

Ben Thomas is launching a new marketing campaign to encourage code contribu=
tions and reviews.
The website shows how quickly it is possible to be involved.
There is also an AI chat to assist in the process.


3/ AI review of existing code

The AI tools (especially Claude) can produce interesting bug reports.

The main challenge is how/where to report hundreds of issues from these too=
ls?
Bugzilla does not fit well as it is more dedicated to issues found by human=
s.
Stephen proposed to publish AI reports on a static web page.

It raised the question of Bugzilla triage and maintenance.
We can send more reminders about open bugs.
A new tool could help for this maintenance work.


