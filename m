Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CCA606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rwK30edX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5329440268;
	Fri, 23 Oct 2026 19:11:47 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id A6A1040265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 19:11:46 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e8b20a899fso6747945ad.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792775506;
 x=1793380306; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wmdmKHBWGekbFIzBtCd0GEFVMx9QsEbYJHweKNbkVk4=;
 b=rwK30edXBe49UQ0f73p4t/aPb53yw8rOnTvEzkN5yKe2+mcb5iGIYv0QRRwMkjq+Vk
 wVd4N4L11G78KMdMRcvGM41KNHgdKgJ5SMSpnk3eeRDK6AJ5uvev0r9yymtapZ84JcoX
 Dt8JjTGm7SzUHvLFTTmfRZNhEBHZDXv/+wgE4ZTk+ow4S1/LMd3Wyj4GCYJwcQUUkQKG
 lAogi35DNxyLHxjXC/K2WPNZ9MMG2w/tfHmQFPy5TaBF2D9Esb7fUrgyYo3qMvUAxlxl
 MlBr0VKL7errC7ptsJ/06j4vSf2TGI2HcbSwBhdu/BZE+kCJlamzRh23s5iKkBosaW7m
 C2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775506; x=1793380306;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wmdmKHBWGekbFIzBtCd0GEFVMx9QsEbYJHweKNbkVk4=;
 b=cG+o6LXHK47A81d+DZ0kAY5AIxdkR+sdfmMsI21rlmqZlueX3m6VCigaJh/q7pDOSm
 /qR1VEQt0ilmsFlmWubsPwKeJJ8sLJNncsMg82AMiLnJPN1K5AsEL4/piD+DbnCXz1w3
 UAjVyP809dxxdI6uDTpXVdlOPBavqc1gjMHfZ0e1b2e0R0IxEa4vVOw+axcmirs2yNEa
 vojYsUkaw+NpSWzKLTt9lRjHN0gc0KfRNBs/vUvRdW2iW1NnmsgivJSkaeqpwwIj/j/F
 mui7BxtG56SknNIWHWSnXZsvdoaxSSNXoT7L84zNrNcHm+m3xZLrQR5F7jgidlaqJd8o
 Bv2g==
X-Gm-Message-State: AFq9FYJnZbNfnr/c0cvTjhtXbk0prmhL74eqVzM/NlfR6bFvSp93rZqv
 ZAWsQXm9sQeislYRnXYPvBmQ6I7WoZ+J5IF9VOUiAt/Ji/CvHUFBd4mfcaIN/6sAuvq+B06MKFw
 ch1X15kY=
X-Gm-Gg: AYBFou1hS1DXlvdy758/LrD6IXfTQnWMRFudc2iT/cr+qFDpwFALX033OJ85QCaGbet
 6Q9Kd2Wct7Q0pgpDug+zDFvZqXxnXphWpEhPC6StDZ66eG2Ib7EGdKhNGlC4ydhlAQMudFrze/A
 u3HIv86fTjMEp/Gd3RZwMyaA2ZMjTT03zXnqYnhFjDfVAPBEyuXnlN1LV/ogtdegSzbjUZfYqbe
 2BCLwDNZtikd2q6BryM6eBVdX8xkMdnDOAYWEC59u2qPJM+fEF31vVvyiKPCeRA00vSqKg5IaGn
 dp6PJ0WLFzgfVpZAOnxDMtnQIabehUTObOZVIC57Sa0pSCQzMnXdh6ZcAuHeruR5TeJH+UOx0di
 b6lGuosuzapElj39pB80ll8mNCEqTk0k8gZUIUyLDr8xvpHtvjLyLUTiYhlazjReokUOOemB3aY
 wI2diWZDrXLGrUU8F0eTVxoIuXtsvErDrfUustmXVclM05d6gzDBF9GoOUV5TcnwdXH8cQx8rqE
 Dq1V0Nwq6FGU4Wllz6a36E8u7hzJT9Ct9zOVdO10EZ4mrvhr+Y0SVGXNgGv1Z5zV5OwqTcsqrBJ
 4pTAeUXljLF2OGijErFNUw==
X-Received: by 2002:a17:902:e811:b0:2e9:514b:7a73 with SMTP id
 d9443c01a7336-2ea7c341171mr27962215ad.48.1792775505701; 
 Fri, 23 Oct 2026 10:11:45 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea946778ccsm3124315ad.9.2026.10.23.10.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:11:45 -0700 (PDT)
Date: Fri, 23 Oct 2026 10:11:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] fix AF_PACKET PMD rollover fanout mode
Message-ID: <20261023101143.6b47a0ea@phoenix.local>
In-Reply-To: <20261023162247.276245-1-frank@dressler.pro>
References: <20261023162247.276245-1-frank@dressler.pro>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 17:22:45 +0100
Frank Dressler <frank@dressler.pro> wrote:

> This series fixes a bug in the AF_PACKET PMD that prevented it from
> running in rollover fanout mode.
> 
> History: 364e08f2bb introduced the AF_PACKET PMD in 2014 and
> unconditionally set the rollover flag. In 2025, d3bc77ab05 added
> code allowing the user to select the fanout mode, including rollover
> mode. Both the flag and the mode were introduced in Linux in 2013
> with 77f65ebdca but their combination has been rejected ever since.
> Because of that, rollover mode has never worked in the PMD.
> 
> The first patch clears the rollover _flag_ when the rollover _mode_
> is set.
> 
> The second patch adds a test that checks that each fanout mode the
> PMD supports is accepted by the kernel.
> 
> Frank Dressler (2):
>   net/af_packet: do not set rollover flag in rollover mode
>   test/af_packet: add test for fanout modes

LGTM - applied to next-net
