Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D632CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:29:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 300F440648;
	Wed,  3 Jun 2026 19:29:44 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 0F682402C4
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:29:41 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304df7ff4c2so664724eec.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780507781;
 x=1781112581; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJHjveMZptXlagWN8p94bsok6i71iw35RMPTN+cSP6o=;
 b=zpX38qmrO+wQZJfEG59vZQTrAVVX+blZZ+vd3ipUd6iCiBpSCWu4bbNV7XD2ZXQEv6
 OP0fNExfka6OMAQhln5wytEcn3Y86f1VfIuYsfW1tPiINA07Fb2k3emRdFdiLnvFZ/ra
 zUNn8A7NzeJORWqfrbSu0sFXa4z7e76d8ghuoUNyTXeTeVCcu6ntJg+lZuZeMsSTx4B+
 ZwcOpbTQoRidMkN1+G7C1pwsMwewzxZM1tbb+tlTvT20z59Ejtgu8KZyWKmd0NNsoU2L
 2cWi82ClM3kLOT39A9PGwVBm36m2uo8lmUGDJnYrnAeAcxV+OAH/JhhJ1jVgUxoZVMo2
 cFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780507781; x=1781112581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eJHjveMZptXlagWN8p94bsok6i71iw35RMPTN+cSP6o=;
 b=WOjNqtvBGaaaRy1ABk25m7gXX1hD5dZc0pfmLTnV/42qyzFZN7gbAisN3mkBy6KH2m
 vVl131edVBazgvAkxJDk88jKBnGvDzqZPJ2lIakeboxgqAXD10urRU3CJTSfytRoQULH
 vHl5N8eoF1kp3x4aUHEAzpMPbgoej6sjLHt9kRvKsy7E968oURER+c7ChcWIxCiAFeAk
 crBcMJjKxkfi12/pNgnMDiOEDUHgEhrxH1gnKaqLHwl7EGXZD6S+mRQoYyOMJsqZAoSG
 4ynbzI251P7+l+zyzPpJso7r5GdWZA6nMgisO5ejKoOMs/hw2YZ/RjCATgJ5FKhDYYf8
 xciw==
X-Gm-Message-State: AOJu0YzJhfRk9q9+QHV8gfLF83PFCai6m9LwOIXg4ecv8oISC5jLw1ge
 IyfGojXy+C2y21/zYZh2pXtCpmehpNamx+WHFjRgD1/GjTlbbuCNfrMd/VYtDNUC7pQ=
X-Gm-Gg: Acq92OH73qA1sEvlxB+JMyr41usnHdosqBvy4kxtrIhX1D+ckX6rIGGV2gQLeHbEb5m
 IBhpWy4UlEYkIowYUDa0RkPRixn99pjORK2BKtXRCvHz0SeO6rGack0ixzCvQqbOU0B4HYIHE2B
 Q9W60lrXozIJdrRDK0RIEhk2NPQWGJPX1vet5dOypWt2ba6P2OWijdOaSV80OF9Te37K1MueuN5
 nNJ7/68nPgWxlxDdaUGk+dfk90uHox9zMPHEIhQ/ipwRw1kto2iepWuFNU90FVl3isX8b8lBuUR
 YTRbmVgPCx/fAs1a3LnofvMSe3NsVLnQ2aREUofusprEjGRBgT6mAbp08KiSnJ0R2jsx6tN/+5n
 8B0Z7q8KyxfnpV3s+Php9Ifg/CIymR8Mrtvl2WJnAtvaTPMbjVsd90chFtW6OmBe1/KjtNgewQy
 V//95I6dvVBVEDm2goi0MY2TWHFSCZGourjNKnm8i1R5LMxaF8DiiO0mRu8PA4QCob2swNl2HGk
 fM=
X-Received: by 2002:a05:7301:5f85:b0:304:dc2c:3280 with SMTP id
 5a478bee46e88-307622bea98mr139353eec.14.1780507780922; 
 Wed, 03 Jun 2026 10:29:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dba046esm2554018eec.9.2026.06.03.10.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:29:40 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:29:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH] net/ark: validate IPv4 octets in address parser
Message-ID: <20260603102937.33b3fc9c@phoenix.local>
In-Reply-To: <20260603054742.120101-1-denserg.edu@gmail.com>
References: <20260603054742.120101-1-denserg.edu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed,  3 Jun 2026 08:47:38 +0300
Denis Sergeev <denserg.edu@gmail.com> wrote:

> The IPv4 parsing helper used by pktgen and pktchkr reads each octet
> with "%u". This allows values above 255 to be accepted from the
> configuration file and encoded into unintended device register values.
> 
> Reject parsed octets outside the IPv4 byte range before assembling
> the 32-bit address.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 9c7188a68d7b ("net/ark: provide API for hardware modules pktchkr and pktgen")
> 
> Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
> ---

Have to ask, why a driver is rolling it own IP address parser, that is a bad idea.
But then the whole builtin vendor pktgen in a driver is bad idea.

Claude scan of the driver found lots more issues.
Hate to think what Mythos would find here...
