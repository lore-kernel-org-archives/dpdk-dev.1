Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E0606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=saruROhL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A664040283;
	Tue, 20 Oct 2026 17:11:34 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id F0A694025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:11:32 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso15783885ad.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792509092;
 x=1793113892; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B8vukYpHyB2qsXwfJ/Tm1+WEc4ztDK5YmKguh46nagQ=;
 b=saruROhLeMMkFHkO9rUmMKUc8mLrFVI4M9OWJC/Ak3UHfy3gRj3Y0peff15Ny48QiQ
 +T/stVh719AHGRrCfWFAb9Te5hmAdJw1K35dnAYqkQ2ZTo6ANVq4Cmay5ar+/5bZlWa9
 uYCYrcLmG8pUaWVTMZjZllK6Q5kFjKmzwi9nKGH9jy8jvOvVNY9aNme9sV2O9E0jJuAG
 N7Q3TUAE7rwkQcjdxT01260OKYXTg0js2LLnY6xQN7yOsV1w+2Fa2LtZN5lib0ENtl4W
 6WHoP8eVysMa1YCEYADZSxJImbD101vTaQi2YgnMOffTl73kYo5VkcfToZN6LnBB6r4D
 mBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792509092; x=1793113892;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B8vukYpHyB2qsXwfJ/Tm1+WEc4ztDK5YmKguh46nagQ=;
 b=UN6ZFUv/36MJm6mLr9oCqbo8ZORfDpt88SPPIUS1kU5a+Fg1vokNsdi6byy5vrBUhl
 vuaP5TdcSGDMt0WIqOQGgTxuvPTqnX0RjW4AOdagi/O7nFT4XXDC3SfmG2wZJwSCYciT
 iFXJou3cIKfiUDepGPq3uEJJeXDoieu7iwY+M3RGI72kjd/k3SuhKjKM/ASPtnysH5jw
 xRMHbCPgrEiCs3EVdQbDZaCwNLIHS0rZa064JDjdCx7AoSbAzbLl9aUR8484ZKd9fO0h
 mOKdTRSq2IaPVmuFWHh2u+ejwmoHsEGh6N+Fq+riPpSAhAgIeLdnHz7uVxWK/prmi6Hk
 Lu9g==
X-Gm-Message-State: AFq9FYJYIKqseSl7nMki4Z1tZbsT8Zao6wTnwWAkg+ImzufA2BEF90FW
 UeEDK4dM/tPb7cEuDHInc7/Vifer3jS943//dCkRw54W8oF2l62WMTJcbjvTv3TxHqg=
X-Gm-Gg: AYBFou1THMfwyl/r6eexmIhR6WH2RQCFKixENwkTGfJCYi55+1D9H6pseHLUaiwFKG0
 BysRBsnkuE+hVzVuzmtvsnBVy9jcsMd3a74fnQdGkiqYtyaIlhFSI6yn/bCeFIc4GzBih1vqkoW
 Jke8srnY2llqL6mhi4WUElxFA2/8aEK+AwJLsG49bF7/5fOajr6aqHjg5EcnSHr8bvjRxo4baco
 S3Nymhg5PhlmFS9OVEd5PjBLgGnyAQJbsxexkNnDJ0EaAxe/crerV32A6oZRBpOHYPeq93YUCIL
 Worec7Aqg+3DFDJdaF5UIvXb2Nruh4iz1ds3oFuUkVkMFw2/0PivR1EclELHfeCISKlzQPmAFfP
 SQoems9q1fMAWEOK+fl9n3LDDsY9FRNf9odtg0yIIYUqVsNMKAIMnVvk0K2AQqsDQiWurV2snIp
 mIpCmIFdl3z/5oZ7VyTP3ZdrdgXP6xuxXiEUEB7kNfmlfuWliBB4NDmwuGnzTvNnnd9HlWdN8Vb
 JgqEH3PxbccV9x4ixrDmUHhWgdMj4LKFFqAJ9FCYIi5YNz1e0I=
X-Received: by 2002:a17:902:ceca:b0:2e4:4eed:5cc5 with SMTP id
 d9443c01a7336-2e9a6c1df91mr96184295ad.38.1792509091744; 
 Tue, 20 Oct 2026 08:11:31 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b4a1762sm386925ad.71.2026.10.20.08.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:11:31 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:11:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com
Subject: Re: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
Message-ID: <20261020081130.7241326b@phoenix.local>
In-Reply-To: <3de75531-dd3f-4953-8fb8-1f654b74f050@gmail.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
 <20261013074555.1ab5dc7c@phoenix.local>
 <3de75531-dd3f-4953-8fb8-1f654b74f050@gmail.com>
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

On Thu, 15 Oct 2026 00:45:00 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> On 10/13/26 22:45, Stephen Hemminger wrote:
> > On Tue, 13 Oct 2026 22:00:16 +0800
> > Zhang Tengfei <zhtfdev@gmail.com> wrote:
> > [PATCH 2/3] net/txgbe: do not enable flow director on flow validate
> > 
> > Warning: validate now accepts rules that create will always reject.
> > 
> > txgbe_parse_fdir_filter_normal() can set
> > rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN. Before this patch, with
> > mode NONE, parse called txgbe_fdir_configure() which returns -ENOSYS
> > for anything other than SIGNATURE or PERFECT, so validate failed.
> > Now parse only checks for a mode mismatch, validate succeeds, and
> > create fails later in txgbe_fdir_configure().
> > 
> > Keep the cheap mode check in parse so validate and create agree:
> > 
> > 	if (rule->mode != RTE_FDIR_MODE_SIGNATURE &&
> > 	    rule->mode != RTE_FDIR_MODE_PERFECT)
> > 		return -ENOTSUP;
> > 
> > 	if (fdir_conf->mode != RTE_FDIR_MODE_NONE &&
> > 	    fdir_conf->mode != rule->mode)
> > 		return -ENOTSUP;
> > 
> > [PATCH 3/3] net/txgbe: disable flow director when no rule is left
> > 
> > Info: txgbe_fdir_disable() restores a single packet buffer layout
> > (PB0 = rx_pb_size, PB1-7 = 0), not what txgbe_configure_dcb() set at
> > dev_start. That matches what txgbe_fdir_configure() already does, so
> > FDIR with DCB is already broken and this is not a new problem. If
> > you respin, consider saving the PBRXSIZE values before enabling FDIR
> > and restoring them on disable, or reject FDIR when DCB Rx is
> > configured.  
> 
> Thanks for review.
> 
> Addressed in v2.
> 
> 2/3 now rejects modes other than signature and perfect while
> parsing, so validate and create both fail for a MAC VLAN rule.
> 
> On 3/3 I left the DCB packet buffer as it is. Enabling FDIR
> already clears PBRXSIZE(1..7). Rejecting FDIR when DCB Rx is
> configured can be a separate patch.

Still waiting for ACK from a maintainer of that driver.



