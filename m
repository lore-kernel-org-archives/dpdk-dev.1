Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D20CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 23:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A77E440279;
	Thu, 25 Jun 2026 01:07:12 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 499374025E
 for <dev@dpdk.org>; Thu, 25 Jun 2026 01:07:11 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 868667A007E;
 Wed, 24 Jun 2026 19:07:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 19:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1782342430; x=1782428830; bh=UaWv4wQIUZoQ6xqMaE0g4
 BDGBEscgQefjoX8tUwINag=; b=WsDUlEoSmsNUFftYpLUF1rQfseQCXeT+e47Eh
 P3Rz27QsBoN2mG9YrefkXt/FlNdmg1v69XP5xlKNvi17OBn0ElUA65gOa5cXn5VL
 kwbDHXF+Yyd04ivohAIwYMmanZiMKrBb669IIEGhTTUwZhG1uf+sJvJQVzddzrdp
 nKZzVvRdI7ATKZa2JVFMFoBGnpTPITccCCRvQyqMF21YlD8AGQtyNzmqhFJdeefM
 Tsu0X+tsFwqvHj35EGaK0f8TH+KhMrx+uKNraVPCZOHXdWLd3HuxCpb1Dbtp3EUc
 aZuPdIjkTaq9X11QQcDjP+3ckWqg+te2TsmGhI01lScpYSozA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782342430; x=1782428830; bh=UaWv4wQIUZoQ6xqMaE0g4BDGBEscgQefjoX
 8tUwINag=; b=BulwAk8yKGQyAYS7Umqbd6seAACbDA7MUHYbwZxOzReVTP0Y8HQ
 JtKZctfE1dG5HtxZ6yWKDYhOwEj2Pl9uvJEbO3C+BYz34L8ia85Lvcug3GoGZTnb
 nzDjI+gacMf+MaPWeeQZCz1rXSjHiP+MHKLKDg6vul1eSxRNZ9QbH1qTGfT2FJtF
 4FCYU3U0DswmDsrmAMqgtI8SoiwT+C73YwvYjZBn4bLD0YYzJarGAEczmR7iU/S6
 N0xNHRqDmtLnXaWKPGLZP+CEpsxfmP+bCawizZmdTpjauMwi0yR6gU7wqlnON5LB
 UlaOL5hNYIjOSRFZdGiDOBxZsQWSNBZmp6g==
X-ME-Sender: <xms:HWM8ajyDIQUAl8fPsqag2rdA_izrLrz9WIXEIxH0Pds00wEq13_HGg>
 <xme:HWM8anm1JxA7hF9MWt59InuuTYdA7V4sX76BP4pCRQp8b3xdjvBf8GMEWP2aWNt7O
 O2gQAsjVkXKiNO7jGipm4lkZJMt-GFCU2kEatQSF7OldJVY3WTjXQ>
X-ME-Received: <xmr:HWM8agEEftam9tL2t9qx0VsbHCIcxxNt6U_Hgv0Pr1aBLVEvXI6h2Lj8sn5GP41RjEdadJbjpTPpIwy0JTfIWOY1rVRV_gI>
X-ME-Proxy-Cause: dmFkZTE49odpMrU1zo8vbwznlDTF/fThwy/e20XDk83AV0CZcdCdaAgLUj7eCRz7Q2I7qd
 ZjYG6AvhvXggJap6ohqD7o5l3YwRcmcQCn0nl2BVnx5b3y2BH//Ypfk0G+MR74TXMBz4bx
 6IWO6HwkV5RpJecal3HKbxgQQ19mGL1DCv+hxD9/DD6TejAiRzn2g4/ZqBSPPIldxpRC4G
 /6HS47+Wb/KHRi2Q20l32oMFr6gAz2nRiVlMjPt7OTbjfa2BX8d3I/3Ycob/6OzNSer/AV
 C2shkfxOW0s1VVTfxTavHdH0uBWswRbXr0dhUB3sAg+fnfCRJ6jefXztQqCuRj4OX5tJXh
 MuJqgSBD1Qk8FlMR6E7i2yhkbnH//OmpnZ+ub97E8Z983Tc491ywJzkEOv29WLtqu360Ba
 7l4sOk4ENkePxrgUnm5LHeJfpGTiL+MVkC6Tj8C6lZozLUCjfujm/AfCVDurDdYiOy5d/Z
 HlD61jFDAgUATxUgM51msjZgbvBFW61WubiOtH62COqPlvU2EnpTRob1lO7iRxqXsM8c4w
 J8wNvJgzth0MrtXt6Ikjeonaw14DCCGRLieT+F9/nXXpoqctGfZVTGNOo+hsumH99yrUX+
 2nEw7MbwD9QE9qdKmq1OHxiPY/rJLw517WTLUK/36bVsncbw4w2WzgeUekqw
X-ME-Proxy: <xmx:HWM8avU5wPL0R0pAAkDn-QMeq1QHcYD2BZsTNalIHotCLRvSMQr2NQ>
 <xmx:HWM8anzBDygJYFJz17Leo1QJ0bPNwe--vB8D5VvYsxHn_xRKjCk2tQ>
 <xmx:HWM8atMStUTyiW4HyFcLceQgGaG8nTEsI_dqlfxGe3owepAyyorvjA>
 <xmx:HWM8ao4TTS6qIwcC8hUsCCcd0J1unY0TS_9XeHV-u4gyNeJn0UR-qA>
 <xmx:HmM8aiaP4ILcRjBp4GjXyoqdvUowU6IEUGViY2tvB0l9AFddWbuacJas>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 19:07:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH 0/2] fix Rx split in testpmd
Date: Thu, 25 Jun 2026 01:03:21 +0200
Message-ID: <20260624230656.2172633-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Adding selective Rx in DPDK 26.07-rc1
introduced a regression when configuring Rx split
at runtime with mempools defined on start.

While fixing it, a test is added in DTS,
and a refactoring in DTS is added as first patch
to make the second change smaller.

Thomas Monjalon (2):
  dts: simplify packet check in Rx split
  app/testpmd: fix runtime config of Rx split

 app/test-pmd/testpmd.c          |  3 +-
 dts/tests/TestSuite_rx_split.py | 59 +++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 19 deletions(-)

-- 
2.54.0

