Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D7AE909B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:54:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1933840261;
	Tue, 17 Feb 2026 15:54:29 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 91FC6400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:54:28 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso37205025e9.3
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771340068;
 x=1771944868; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wm1Bp4SLVlRMkasZ2CiHexfb5ZI7FqDkXW3nxfknhmQ=;
 b=p/oxt6WpxWy3em4tEqEFsa5hOPY66dyrH4efuDZwDdOPePwubgkGHS2XlikWfIdoYT
 iSqYM6epGDPBqoBWnrhWGBNoziX8pa0uSEypHgYvL30CSsr+L9R78bCGTcHZ7qhmFrNV
 myl7Xg7rpqiRt8Qafxm3BVHV9T97KRrOLC2agEj+fhZXO5CGpjIGso/iFplo5q1HxB+2
 3Xwonk+YQG2wJpnnwa5Nq8G7mmPm9y7DmXQEYrYKtORJkcmhxBNkduOFOhrOmrPEFHpQ
 rMNFurV6veQ8xomWddGAdLVNO5RG2ObwGWwAucHzGdzG8p0jSNDAsX11QNueqA2TAfou
 oNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340068; x=1771944868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wm1Bp4SLVlRMkasZ2CiHexfb5ZI7FqDkXW3nxfknhmQ=;
 b=QGFhK/tlNJR8NWLjIo1tV4r4Zuezzm7tudBqJtyCEaWyM98ltSQ2aOSDecJQ8oa4kL
 X3rfoT8cbo1mXw+24BPzuFEUfex7jset8FoSTSKcNZzOmlNUqcNKyJpjU0eZs4eZW97E
 MkOnHjfmxKhTxJRn9ArbbD++XE3jj7tZuioaABQLK1hpX67eGc3/0m5PmOc7DfC/MZiy
 p7QPwMlU1ZwP5WKgAOKMcgCfsxIHUZ08StmdsRTW4E6ltqs/6rMMT2o4pIXCF/sqJ1Ec
 ww/unUL5PAImD1e0kW3sDdOEbu+LIatsGRpRvMad3u7nXZBAXDrcdTiOFW1Q0QqEID27
 Pxfw==
X-Gm-Message-State: AOJu0YxbzTbVKw7F5PgVIC9tGbsInpcLytPKYXLhcv1bSzw/3zT6VPTq
 +vJ/rKpl/VD0xxrc43tAbBQ+XewGKWryFQt4piM/dJKoRsBXGRf2yqjpDmP4CntI+cswYr4O6o4
 N1cxG
X-Gm-Gg: AZuq6aLmxJ8VnmVHWtoYXrFlxe08rLkqmhj4UK0Eq/6c35kAoLrsUc/G5xYN2CyUZTu
 Nw3Tr/exkx4Iq11nfdLV6rvlJhdYRZbO1dAgZGDRrCmlIseBi/BThZoX9oVSXNkNVz+M0AwltR6
 accm82THF89FDG89Yf9kJwvI6zYRNK1sSDzcJpnsRcf1/DATNKOtcl4nNP8feYHBTL6+vphhgmC
 xL8AfU3Xtq03sh3/jI0r3qLvE9YpUxjCPdZg1Jy+YM3awXDD8ZPIOHQA5aiM8XyZSwZ20Hty36W
 jdU/Bi5/wvZmXdQu94mu1q/hifLN32bR285gN2li5io0RoShmr9MYYVkc2Z/UrFBomfu22hKHLd
 Ol2O6P7tXRzxrB7xl7dO3vstWNhZzJT4UuDVz+EaKuaTQxn1EbJEKh3cW0HXSm0XiYkabl6R49/
 7oKosEG2D4JnAGQfep28iLR42ADt/7mzYD11VNYTWzAgYYYtlGKCTnEW7C+sJo4pZ+
X-Received: by 2002:a05:600c:5491:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-48379bfd732mr187961065e9.20.1771340066894; 
 Tue, 17 Feb 2026 06:54:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48378b5196esm131144515e9.8.2026.02.17.06.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 06:54:26 -0800 (PST)
Date: Tue, 17 Feb 2026 06:54:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Message-ID: <20260217065421.22fca263@phoenix.local>
In-Reply-To: <b361cfbe-039d-437e-b628-5cb9f923bac7@oktetlabs.ru>
References: <20260216180011.393782-1-stephen@networkplumber.org>
 <b361cfbe-039d-437e-b628-5cb9f923bac7@oktetlabs.ru>
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

On Tue, 17 Feb 2026 09:41:07 +0300
Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> wrote:

> On 2/16/26 9:00 PM, Stephen Hemminger wrote:
> > The documentation for rte_eth_tx_burst() uses the word "sent" to
> > describe the return value, which is misleading. Packets returned as
> > consumed may not have been transmitted yet; they have been accepted
> > by the driver and are no longer the caller's responsibility.
> > 
> > This matters because the common usage pattern is:
> > 
> >      n = rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
> >      for (i = n; i < nb_pkts; i++)
> >          rte_pktmbuf_free(mbufs[i]);
> > 
> > For this to work correctly, the contract must be:
> >   - tx_pkts[0..n-1]: ownership transferred to the driver.
> >   - tx_pkts[n..nb_pkts-1]: untouched, still owned by the caller.
> > 
> > Several drivers (and AI-assisted reviews) misinterpret the current
> > wording and treat packets with errors as unconsumed, returning a
> > short count. This causes callers to retry those packets indefinitely.
> > The correct behavior is that the driver must consume (and free)
> > erroneous packets, counting them via tx_errors.
> > 
> > Replace "sent" with "consumed" in the return value description,
> > spell out the mbuf ownership contract, clarify the error handling
> > expectation, and update the @return block to match.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> 
> Thanks for the clarification. I really like it.
> 

I haven't reviewed all drivers but have found bugs related to this
in tap, af_packet and likely other software drivers. The hardware
drivers seem to be modeled after ixgbe and get it right.
