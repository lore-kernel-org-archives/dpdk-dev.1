Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55536ECD98B
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 10:00:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4E354029A;
	Fri,  6 Feb 2026 11:00:00 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 172D140293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 10:59:59 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 84AD11D00175;
 Fri,  6 Feb 2026 04:59:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 06 Feb 2026 04:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770371998;
 x=1770458398; bh=XDM8g9kzscdtXABpIja10wRzBE9jGnUpyoVPNJv8QU0=; b=
 aEvGzJRwl4NpGtghipclRqFNrVQDHuMoUu/gnBOvS4iyhaHwmugabClQKGfP64P1
 4AFcTpIjarSrqkJCrTtR5aAjGqG+S7z0xraDzebpYY4C7imhj4ilsfn06UJHXf/i
 VBmgLqXCX9biPh2OKaYOw596syZQp865Ts1JoUzVsv9PvRPVjyadTDAx60+Xo1RL
 XytuuFFD86AhbBmmmKtLGgVFyV6lnMcuu1XRsARO6d/wxrYbMN5arjqXAmViQviW
 VyMO7Wz7FJ89M9hjIgEuEMucOcyPfewkcoqAg2qPM6vJ/HmJSCjmsUVJqDpb/uAE
 KkUUC84Ho8cStaCO0Myiyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770371998; x=
 1770458398; bh=XDM8g9kzscdtXABpIja10wRzBE9jGnUpyoVPNJv8QU0=; b=P
 UJfCNTyuMsy1XVEweLpHNvGBMj9TbEjLBr1K2LxsmEQ4zfHZQNKDkmtwuLERKEkK
 4Vu6WKgg9mqr8dKviyRpU6eXslU2VIsEiWzR4cuBS3t60pniMjE/tj1gkFAVw8wC
 hTGtrUkjtZTcCLht+doME9fWT2dzV6Cp7uuHHz5QEsNW11oxlw2Hw7yANN4mwNhA
 MMcZY8Kycqe7enMmE2Mm7H7Czmqjg3M/g93wxRRRkFTh9LLMjjzhH9DhLwp9NlT3
 /gmV8/Ld/0qLlkvuIgAGY8Gzk00pUcE45RYuMVFD5i7RZX+nwAsBccqGaP5iRYpq
 2yRvnznP/mUxwuaYK7HwQ==
X-ME-Sender: <xms:nruFaczymkcU-M2dAdGsTZ74ebebKlSpwIcRBbg8_Y4DRjOQddaLzA>
 <xme:nruFaUmUxAxSo_0bKXUk9e02ei0C7HlJe_I9KxxFTski6D4-QEEdpol0mSKalX4pI
 RITrBDhMOO5UamyHGxbQ2xt1EcpkPhL3u1pfnCx1awjo1sb3vvi>
X-ME-Received: <xmr:nruFaddrzemM-td152dXae1rk5HPNsk_n3i3Q4HGX4ZVUB3XJoCtGI16IZ-CwPJIiHdoi04umgJrVTyQpQuGZhVkVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejkeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 oheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:nruFaSoMYKkk96JNgfsINqsplC-zZfP2OynXpY8BfVHGen9xHX6NHA>
 <xmx:nruFaT7yCEBgumhjj3qKLDbgbKACFWZ4QVvCxnVy2IfutlxB0QYnqQ>
 <xmx:nruFaQpcZUvpq-rB0fpQU2L8Z01qj51TYW8Ews2-xs1BfvioyFb9AQ>
 <xmx:nruFadinchpynA0_PAJWTRIdxdnq6guBrehQmqcUAA4Q-xaA17CBVg>
 <xmx:nruFaWDigCy_GxdC5ZKbTQ8xTIC3vv4mdUK-E3o69K5P7cQKLHcUKiyJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 04:59:57 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v4 02/11] mem: avoid hugepage path overflow
Date: Fri, 06 Feb 2026 10:59:56 +0100
Message-ID: <3110000.OBFZWjSADL@thomas>
In-Reply-To: <CAJFAV8w9nyJU92feqy9KJme4WeTnv5k4nOXgc3=hBsnGU1VMWA@mail.gmail.com>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-3-thomas@monjalon.net>
 <CAJFAV8w9nyJU92feqy9KJme4WeTnv5k4nOXgc3=hBsnGU1VMWA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

06/02/2026 09:12, David Marchand:
> On Thu, 5 Feb 2026 at 22:30, Thomas Monjalon <thomas@monjalon.net> wrote:
> > @@ -446,8 +447,14 @@ find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
> >                 return 0;
> >         }
> >
> > -       snprintf(hugedir_str, sizeof(hugedir_str),
> > -                       "%s/%s", hpi->hugedir, eal_get_hugefile_prefix());
> > +       ret = asprintf(&hugedir_str, "%s/%s",
> > +                       hpi->hugedir, eal_get_hugefile_prefix());
> > +       if (ret < 0) {
> > +               EAL_LOG(ERR, "%s(): failed to store hugepage path", __func__);
> > +               goto error;
> 
> On asprintf failure, hugedir_str content is undefined.
> It is safer to reset hugedir_str to NULL before jumping to the error
> label where free() is called.

You're right, I do this small change:

        if (ret < 0) {
                EAL_LOG(ERR, "%s(): failed to store hugepage path", __func__);
+               hugedir_str = NULL;
                goto error;
        }




