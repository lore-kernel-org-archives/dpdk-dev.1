Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D31C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 14:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97EAD40609;
	Fri, 28 Feb 2025 15:20:16 +0100 (CET)
Received: from mail.citrus-it.net (mail.citrus-it.net [89.248.55.101])
 by mails.dpdk.org (Postfix) with ESMTP id 69F50402DD
 for <dev@dpdk.org>; Fri, 28 Feb 2025 15:20:15 +0100 (CET)
Authentication-Results: citrusmail; dkim=pass header.i=@ovsienko.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ovsienko.info;
 s=2022-04-13; t=1740752413;
 bh=UpYx06XyXY25r/Cse3Z0862aHfAC6quKxH1zPb4MFgM=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 b=fph5gq+R//0SBhnqN4G3VcdLwDJs2h8VG73vXIdvQeCXORqPizG54RsrsTl1tL8Kx
 ggfKKp2bxVSDUJUixFLdGK+stjGdy1PQbiDA1FPkwGbVcDj6AI5UjEbIyVnDzWaqWo
 7nMMsE00AyzpCsY6cuKhliyJRj4Ke7VuevJg90QzsTbKAS7PRt24scx4fOKnUgyV1l
 OPi8I2k0wSt2MjT4DG8ArEdOm+A35QSBBFCMnBOtGkg0FQsLql2K4ieftQqYmIYqCJ
 NR63lJ7xbR0vVKu2pJ3wmuremUxMptmoR6wIrkQv5kGHVG/XRDdwXo4R1hsB2Zqz06
 lVBuvzTB/3NmQ==
Received: from mail.citrus-it.net (mail.citrus-it.net [89.248.55.101])
 by mail.citrus-it.net with ESMTP id 51SEKDQ6003487
 for <dev@dpdk.org>; Fri, 28 Feb 2025 14:20:13 GMT
X-Citrus-Remote-IP: 129.151.92.78
Date: Fri, 28 Feb 2025 14:20:05 +0000
From: Denis Ovsienko <denis@ovsienko.info>
To: dev@dpdk.org
Subject: DPDK support in libpcap
Message-ID: <20250228142005.1052bd2d@atlas-11>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Citrus-Version: 6.0.3ba253c
X-Citrus-ID: 751SEKDQ6003487
X-Citrus-Spam: Whitelisted
X-Citrus-Trust: Trusted
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

Hello all.

libpcap has been implementing DPDK packet capture support for some
time, in that a contributor added this support using DPDK 18.11.  This
code stopped working with later versions of DPDK and still remains
broken.

Would anybody be interested to upgrade pcap-dpdk.c in libpcap to the
latest stable release of DPDK, to confirm whether it works as intended
and maybe even to keep this module better maintained in future?

-- 
    Denis Ovsienko
