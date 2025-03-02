Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC31BC19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 12:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF1C640291;
	Sun,  2 Mar 2025 13:23:34 +0100 (CET)
Received: from mail.citrus-it.net (mail.citrus-it.net [89.248.55.109])
 by mails.dpdk.org (Postfix) with ESMTP id EE9314027F
 for <dev@dpdk.org>; Sun,  2 Mar 2025 13:23:33 +0100 (CET)
Authentication-Results: citrusmail; dkim=pass header.i=@ovsienko.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ovsienko.info;
 s=2022-04-13; t=1740918210;
 bh=EyNq+9rPb9BA3D2tAUAk5cBOekLpbrXv328Snhs+PFY=;
 h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 b=hm1c6bNdebc5Bg549s+3hZg3eaSGF2IV6N13VTRU5BKc8FaJpviz2vHJTTjD5dshH
 r/oi49fZnOZErbSgKLh2HCSEV7k/QFHr2poHKnBPC2iQW0nNv4itf/Op9ENn4WzNhP
 apIiOFka0FkWxCNJj/kOisGSqxJ7zOuNprAjQOTj8q8+GyJHMJjxjdaNodZZ5d+TOQ
 3bY6xMHGFycWwhQEGLnXRbDtmESVT8yA7Z77mFUXqnKmQuPNAd3BjLx5JrtFUGfr/M
 BmRR034baWm5B0SDHz1SorTdQoWvg4//ugHmiMyJD7XI03g/i++suat72IBKUrkayV
 IbJ64jCwStDbw==
Received: from mail.citrus-it.net (mail.citrus-it.net [89.248.55.109])
 by mail.citrus-it.net with ESMTP id 522CNULC002621;
 Sun, 2 Mar 2025 12:23:30 GMT
X-Citrus-Remote-IP: 129.151.92.78
Date: Sun, 2 Mar 2025 12:23:27 +0000
From: Denis Ovsienko <denis@ovsienko.info>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>
Subject: Re: DPDK support in libpcap
Message-ID: <20250302122327.0e2173ad@atlas-11>
In-Reply-To: <CAOaVG14ZUZwNNkBGgD8phDnib7O6_cS476P2Z53dUnjTsxTLWQ@mail.gmail.com>
References: <20250228142005.1052bd2d@atlas-11>
 <CAOaVG14ZUZwNNkBGgD8phDnib7O6_cS476P2Z53dUnjTsxTLWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Citrus-Version: 6.0.3ba253c
X-Citrus-ID: 8522CNULC002621
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

On Sat, 1 Mar 2025 10:28:21 +0100
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Last time I looked at that code it was really ugly, and messy. But
> more of importantly it was the wrong use case. Very few users will
> want to have a NIC dedicated to capture only.
> 
> The whole thing should be rewritten so that tcpdump/ Wireshark can
> run as secondary process using existing pdump API.

Thank you for looking Stephen.

In case there is a volunteer to fix this at some time, this could be a
useful starting point for them.  You are welcome to update the bug
report [1] if you think this would help.

1: https://github.com/the-tcpdump-group/libpcap/issues/1159

-- 
    Denis Ovsienko
