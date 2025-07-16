Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FDEC83F34
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:16:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68BA94013F;
	Wed, 16 Jul 2025 22:16:17 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 17F2A400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:16:15 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-74ce477af25so225901b3a.3
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752696975;
 x=1753301775; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSkqF+S1V6KLWQowRnvpjxnuhvryfLkC4W/OaLjHcXA=;
 b=sBuKsnbOm33Hh7xN50/eJ/vcyxZ1hZAabIMZiWonOLqjxuFqXE/hxXMiA/hxh+rSa6
 myWB0n2W5dieD6vB4JvjCGfNIAARWt2nCHAX95UlZzRZ7eO001TG/SYE2NYO7LmnHz1Q
 5HuPPPoTvez5s0gsK4gB+98F4ZwyGCxhDYntl9KNftvOWDZgCM76rEzl0UALVCZaJz3k
 JIZL5D4rbMf/t6Dvfkn2tAA6hDBn9dMtPhp3bFmjq1JDk+6spvefhgxpHkk4VEIGeuzz
 Eil4ZELhM0CnwJfMYYmjPAMPhoP3EFBNiPEAMX+nq46J0S5xd1HYTKC2hwUOflfXg/9n
 KCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752696975; x=1753301775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSkqF+S1V6KLWQowRnvpjxnuhvryfLkC4W/OaLjHcXA=;
 b=ot86c4i8QYc5rGSDdLSA7NofSCgWuNi2MGTBBXvIgWOfJ99or+/w2HZTxFwxrW+awb
 ys/Y4Ul1WB2XCksX2JKVCOEMsPBxRnj0oByxPvgEbp9yoDCSva1CB+AMLh3/caQI4Vbe
 +Bl2ki+FuQLCkHKf/Mh8fgsVLPKKuwr1dY24M6ZEQj8vG4YBM7khv3eztWTo5vzjSQwa
 FA0/v5wCQcFhhcYi6fmQdB5EmuTvB/k+W5KS7/JbceQCEtvcbxbkdSxFC5yvoA4xwbyQ
 aIHKzAzZ7Y6Po7qB28xerqlmix+2X08OFtWD26q5hxq84QWgogVYBO3F/2s64wiww6l4
 iRrQ==
X-Gm-Message-State: AOJu0Yxie6DnjcfRXAfhwoRW5AKivc4wvxkck5vJdesIvidqUVEyC+Yr
 JybRjDW/FvLxdCHyY4Iktc2a40izuwE5AmkDiT5BSNzy7iMm+yiVwdp0W666hxE/Yrs=
X-Gm-Gg: ASbGnctRxRBDCtAq/vZviLVUNObNtKLlNNKrtbAJzndIhZQBCrbmYIdkhzs1PPf9yLH
 Ka6JdOzJMxrTiNVtKvdLanI9nKx3Bp44jOfMwERFwridb+cSqWMsvfBL8ZtiLEbc59M299STWEX
 naOM5jLFJD/93pk1mMkrKm5CX1gExRdE9b+76II/QrYSxu8T/wyvC589f/CZWPJvEE0VQL2v87a
 NuLIlY+jlSxaUu7DjV2qlrqQjUjhT/muSw3pJ9u3B3CvKZT2fgVKe16q3sUPHGTTmU0C1KHqAkw
 UZU24BuPlH5UCatV/uRLIWr5LQuH4hWs6rWWI8XzsDS8TBn/bU9DJGqS+NVpTx9gt+seRgNcVAr
 npIDyj6WGpkg1Xhok/C5/UqrPBma5Khvqs7tpbSxLDO3QSt5oAdWT9kehxjIGTQ9iYXYhwiPUf1
 w=
X-Google-Smtp-Source: AGHT+IGYLZSJdJXiei/KnCyC1whvcaamb9jihRbXZ7XEDTrQ2pZaZp8szUhwpukTy4h/u8TUyth5Sw==
X-Received: by 2002:a05:6a20:3948:b0:234:dd8d:cc7f with SMTP id
 adf61e73a8af0-238124571d9mr6668178637.22.1752696975084; 
 Wed, 16 Jul 2025 13:16:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe579b0esm14231805a12.22.2025.07.16.13.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:16:14 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:46:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 01/14] net/sxe: add base driver directory and doc
Message-ID: <20250716104600.4b65ae36@hermes.local>
In-Reply-To: <20250716082930.83026-1-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:17 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Some complaints from check-git-log.sh not all have to be fixed though.

 $ ./devtools/check-git-log.sh 
Wrong headline format:
	net/sxe: add link, flow ctrl, mac ops, mtu ops function
	net/sxe: add Solve compilation problems.
Wrong headline prefix:
	net/sxe: add tx rx setup and data path
Wrong headline case:
			"net/sxe: add dcb function": dcb --> DCB
Wrong headline case:
			"net/sxe: add link, flow ctrl, mac ops, mtu ops function": mac --> MAC
Wrong headline case:
			"net/sxe: add link, flow ctrl, mac ops, mtu ops function": mtu --> MTU
Wrong headline case:
			"net/sxe: support rss offload": rss --> RSS
Wrong headline case:
			"net/sxe: add tx rx setup and data path": rx --> Rx
Wrong headline case:
			"net/sxe: add tx rx setup and data path": tx --> Tx
Wrong headline case:
			"net/sxe: support vlan filter": vlan --> VLAN
Contributor name/email mismatch with .mailmap: 
	Jie Liu <liujie5@linkdatatechnology.com> is not the primary email address

Invalid patch(es) found - checked 14 patches
