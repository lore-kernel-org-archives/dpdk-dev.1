Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF5CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 17:17:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9AF340B95;
	Mon,  5 Oct 2026 19:17:40 +0200 (CEST)
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net
 [51.250.60.163])
 by mails.dpdk.org (Postfix) with ESMTP id 34E24409FA;
 Mon,  5 Oct 2026 19:17:39 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:4988:0:640:e18:0])
 by forward103d.mail.yandex.net (postfix) with ESMTPS id F18F9C0061;
 Mon, 05 Oct 2026 20:17:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id aHPH352g3a60-I4DWOzKc; 
 Mon, 05 Oct 2026 20:17:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791220657; bh=JVCqwQXJDLcBpJ7BwiFQIwPK4N2KNHFXNeCbjezHyIA=;
 h=Cc:To:Subject:From:Date:Message-ID;
 b=fxcLzAwYFRuAB6eLS1b/UdJZsY5CSI3TS4k6qecFaNicLWprsV+4tgbO/uMaVHfyc
 251rgOTmSX+ZJOoz9pw3ZbYDBcR7HEFIcn3cDtW8oCcpqgkaroNTJr4OxAf0uCwjXk
 lA/msozTtTzQwzvjWZOU2t0EShdVwnMRcbqO95+o=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Message-ID: <a30b9a03-308c-4b6f-80b0-1555ec62bf40@yandex.ru>
Date: Mon, 5 Oct 2026 18:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Minutes of Technical Board Meeting, 2026-September-30
To: "dev@dpdk.org" <dev@dpdk.org>
Content-Language: en-US, ru
Cc: techboard@dpdk.org
Content-Type: text/plain; charset=UTF-8; format=flowed
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


Minutes of Technical Board Meeting, 2026-September-16
Members Attending: 10/10
     - Aaron Conole
     - Bruce Richardson
     - Hemant Agrawal
     - Jerin Jacob
     - Kevin Traynor
     - Konstantin Ananyev (chair)
     - Maxime Coquelin
     - Morten Brørup
     - Stephen Hemminger
     - Thomas Monjalon

NOTE: The Technical Board meetings take place every second Wednesday at
3 pm UTC
on
https://zoom-
lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f
6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at
http://core.dpdk.org/techboard/minutes
The next meeting will happen on October 14 and will be chaired by Maxime 
Coquelin.

1) 'Assisted by AI' tag in the commit messages (Stephen)
- Linux kernel has decided to use 'assisted by LLM' tag for AI assisted 
patches,
   we might to get patches with similar tag in DPDK in future.
   Some code agents are automatically adding it.
   What should be DPDK patch submission guidelines for that?
- TB consensus on: patch submitter is still fully responsible for the patch,
   it is his/her responsibility to carefully review, test and sign it 
prior to the submission.
   Should DPDK allow patches with 'assisted by LLM' (or similar tag) is 
still under discussion,
   not clear consensus was reached.  Current intention is to return to 
that subject on one
   of the following TB meetings.

2) Rules for names for DPDK contributors (Thomas)
   Current rule of thumb is to always use the following order: 
<Given-Name(s)><Family-Name>
   TB agreed to make the rule less stringent and let contributors to 
decide themselves their names ordering.


