Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E337EC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 02:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFEA540615;
	Fri,  3 Jul 2026 04:58:55 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 3A45D40291;
 Fri,  3 Jul 2026 04:58:54 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 596B140288
 for <announce@dpdk.org>; Fri,  3 Jul 2026 04:58:53 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 8A3E41D00144;
 Thu,  2 Jul 2026 22:58:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 02 Jul 2026 22:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1783047532; x=1783133932; bh=h+A2nFB2NW
 +7Lg8ovlLaKT8XdmR8vEc+pmnkEmdpOXE=; b=Osl3OGOS0g/9IEBISZq7gLFqVW
 hi7u1lKOGhHkr8C0PMVXVr55/8hUfYKLDTzWK88FHLOesNYrc2ZiNJjasH2f/HVP
 G41SPHO87k3DZfoLbliIVRO74bS80lssCC7/ojpgXxlVOPn/cMSkS515o3MN7o6I
 QvbAfP7LDVomxtZt4y5UcD3Y8TiDIpfRzl6vxV5hHjezT6JD7QsoRd6oCqez/Lve
 5qRjnWIQbl/1ppCuzaf/MP20jwd9isrYCL9e4C0tr9TNtY+XEZGqvD6QbRU6lLpP
 e6x1FlhNQLjW/9Vzyep8p5L/50WLi01PHBA/Utyioif7VEFdO5o6An5wudLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783047532; x=1783133932; bh=h+A2nFB2NW+7Lg8ovlLaKT8XdmR8vEc+pmn
 kEmdpOXE=; b=MxbnnmFgFPWzGv2WsmRJHVnuAyGiOkqRBcn5Gqkj8h9el0Bvi5g
 xhn7HP/lUty+do5HYRpxHk9GZe2/Q2aVALncyJ3lZs3YhjMdzkHhVDg6omy+PxH2
 9zyNSrLgDYRDRYvBjgALzD0bP6SXSJUVigTUIEbTXnAQVq9RSsP2mlBoS5URg0IR
 THT5B+txDa7XsXjLsup/xoN9iW/zlPnNjO6CLnBCXYM2EmJGXIq2Z17TGeT7bCsr
 VnZYqzKHKTuaASP3xYuiY+3CKPGWbHLXsXwLKuopdIlfVKguN0jI+0ASRLXJOSxM
 HPZ1Tb013RnvPhvCbLbGK/RZnvFTmM/s/rA==
X-ME-Sender: <xms:bCVHageSOGuaHk27rQPR2iNvxStzII9iX5Li0jQqWaFSrAesV-2uxA>
 <xme:bCVHaoEIWp0O1SRK7mR8Nk2jYI8dmL1SXOG6zYKgBkEMpvL3jszMw3S2GvLFMS286
 BryEOUQQ3zpwqNH7QY2AtWT48K1tNTuq8V7tcJMlGwwvu7XUNMW-w>
X-ME-Received: <xmr:bCVHaslRlqDHJK3gAO02r8f9mKwGmurjZ9gubdy94MTuOobP9m66Z_8-yOc7y154ZQPMP2PZ17dG6wyTW4xvrnLiKg>
X-ME-Proxy-Cause: dmFkZTE8Jau3sIPxedChChkRPi1oAj/b2x2ZLb3PNuAnVj8QbY4Uxu3F7ooexOVNXA1u7p
 Ujvta9TIckqSVPun8DQonncYBDuMUZD1KatiYLO05wDeXmq+iQ33iuninz1sl2NcJbSbot
 dc/PXXeZ0U5D36re+CrPZnZaSyPl//LpafLeK9UXithu3XbiWPrkdZeLdzDvL34Tim1EbD
 h6En3rklXSFWqYutwJadXSGjikj1mDerWpNJwtRWl2kKpsfzPL5xWCsyAG6NakSTImV7Y7
 KcpYhd3pjBRF/0KSls5reKAdw712MBrjImAuSEXa1FkeM676uwBLpRhgyIc2Yf84KP+RSb
 bjj49yTxWkYH/XpwBJTlqgmp/kOn3J0ej45hgfkninKS6tJ80yj6iSxHXs0dil43WPBRby
 SA92hK2AIXzgx7GVaJen2ii64suOcl6696hit+LDNcd9Fv6vjmOW4AqELDQpe1BR5g5Uy6
 CrE+yCgr5lljTJMiQ3eu86H4OzeWljwZ4Nn7wG9q1/NVEJHtKuP+rDVQ79U0sPkWyh4AYm
 WZhIN52/dAKwIoOIXStaqEZ36iWAtaIG9hiMeP/b7ov1J5KclOtD5jaP0YcCkw1y3rT3Ga
 20Lp66XQHZ8iBQYSxw/2Axglu2GBgjfB3xklysM5J2r9MTR0HVVYSCySiQXw
X-ME-Proxy: <xmx:bCVHaix9Z8eSsSmL5IwpApVsnPDNtie8iGbwzbeTddjqjnjZBEyXZg>
 <xmx:bCVHagQ_OOob8xNc7UEYYf99UEwFl4L6da1RrWkc4PVI1aFjTIwplQ>
 <xmx:bCVHatvttTrGOMjTI_JxcGjSkdCWp246t5Rezlhc9NGMZzIfLWs0JQ>
 <xmx:bCVHaqv9MUSdpL3HuHAcRv-NJ_QY0mMNa_ZYsotbXfzUWeRd0oPDjw>
 <xmx:bCVHah8rDYnBApe93BEoihwS9L5D5_rjf9SEHHP8KG2kIkBbs6bJtEpZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Thu, 2 Jul 2026 22:58:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK release candidate 26.07-rc2
Date: Fri, 03 Jul 2026 04:58:50 +0200
Message-ID: <CP3kiV_jTf67aEg8Usilhg@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

A new DPDK release candidate is ready for testing:
	https://git.dpdk.org/dpdk/tag/?id=v26.07-rc2

There are 289 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_26_07.html

There are many fixes and new drivers features.

Please test and report issues on bugs.dpdk.org.

Patches to improve tooling, examples and documentation are welcome.

Thank you everyone


