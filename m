Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13201CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 22:06:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35A9B40299;
	Wed, 24 Jun 2026 00:06:48 +0200 (CEST)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) by mails.dpdk.org (Postfix) with ESMTP id A5C9640293
 for <dev@dpdk.org>; Wed, 24 Jun 2026 00:06:47 +0200 (CEST)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-660e9ff0587so211685d50.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782252406;
 x=1782857206; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPX+RJGEXTHon36TZe3BbgOsnv5/bZBnlWj2fXBgTgA=;
 b=Zl+DCB1l6g+jMMAuI5dxxD050CKjQC6luoWz264qXUp/n3Yk1rRLCgTAAfKUUEA27D
 2S4kzqBKJyUpVQNjaqBAl70MgxwQUKW0HlbkK7QGwz1RC0wj0YGrCBg4t0md5/Jc+/YG
 LqunbB9cuzQxl37wwRZyN1JQZc3nlrFuPUXhU9RykM3WGnpM8844fedNZ5o5UL9hcuxE
 C1VpR98WDURgO8Z/KYNqnoUdQe99u4Dc8Ob2twpf+P4d7SHd7ljNyQym6E+rBJgX0PQy
 IWnvfwmSo5CMMvfeTej2CBkqOPbapbiDCU51orSAv8EA/tJeylIkzPcij748TJo/KP7o
 EIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782252406; x=1782857206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oPX+RJGEXTHon36TZe3BbgOsnv5/bZBnlWj2fXBgTgA=;
 b=RhGTW54vF7WKkwuusJ0JuS7VLYAGTSou1MwfLDJppPUW2PLgAiaNj6+HKq0rI+BH4w
 Sv0PGLKcgG7DR4v8kjlfQOPL4/IG3JpdY6ofEGFDG3dSk2kbBkJzm3+Puj8Dt5G+I15N
 /CyoyWvd5SAtFOK5aUJkTAcoBZ0a/f9I6Dzdr2VDAuIHO0qJPr5DNKG2rw9iGdeP8Akd
 q78Ws6N4H+PYgHxIciLKHpNIKEQevqlOWFJzcX7R0Y4ocZx1purUzgD0EEjPx561PXyr
 pNBUo/WK2mcrgrhRgcFC3wyWbeXj/gArf2DRycok1IxBW6TKI5nh6ChzjEOFxtSlpcwI
 TvXg==
X-Gm-Message-State: AOJu0YwBHOUuGOGoqVI4SS7SQBmvn5I87e3ccu5iCmdecjDL2bURy2Og
 1HybJPZqOTTGyJD5n21MCPAVBNNGAOytRhyL24DmKAyjR/XPxu2TtK3ikyhZS6rIIDA=
X-Gm-Gg: AfdE7ckwM+KRwBQH4x7u5/wU+Dcvh9oftWkHeC9rI8dcBzc4YEBzCqjBehdXD/8LoYh
 D1aPfh5IYVY09JU9UIt1lZcaYdg1fXUlAhm+lJfx3NmmTVluv3zA2nVLvH4ctb2tHXwZFUNU43P
 LI0bl73vRaY39L9LI1al+Btxgjeyf8L87fRNgeAXco3G7MTw1RqktmE2n6zW6/ZCGHmnlgQkoFX
 JcSBu+FCqHOSMB6SigzzZWVi1MhfZvZEaqUje54GNtLbl7kXF1vw6UJKTH2BVwMHVqHoxjtOm5e
 sd9vYucJwnxWiLNCJmlO6Wj0SbY3yYKiI8ICGKjVPUVC4cYDKROz5vRIb3/SPUXPb66QEzVYE0W
 bmwjn2ifx2GaG9rA3S94uEW90mgfgIVLhy/EuBrXxssG5bl/UboN3qEPHIyGhKB9UvNzXeQRs/Y
 iowShTGuv1CgnZDhCoZyKuObpn3BlAP0aJ9C6tf4IOirb1CYiaBtJ33puSNMqGFPDs
X-Received: by 2002:a05:690e:1301:b0:660:580f:694 with SMTP id
 956f58d0204a3-6636e5dcc5cmr692287d50.44.1782252401741; 
 Tue, 23 Jun 2026 15:06:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314d8dc0asm5830091d50.17.2026.06.23.15.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 15:06:41 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:06:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, Joshua Washington <joshwash@google.com>, "Jasper Tran
 O'Leary" <jtranoleary@google.com>
Subject: Re: [PATCH] net/af_xdp: add Rx metadata and dynamic timestamping
 support
Message-ID: <20260623150638.266d8574@phoenix.local>
In-Reply-To: <20260623215325.814776-1-blasko@google.com>
References: <20260623215325.814776-1-blasko@google.com>
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

On Tue, 23 Jun 2026 21:53:24 +0000
Mark Blasko <blasko@google.com> wrote:

> +		if (rxq->rx_timestamp_enabled &&
> +		    timestamp_dynfield_offset >= 0) {
> +			struct af_xdp_rx_metadata *meta;
> +
> +			meta = (struct af_xdp_rx_metadata *)
> +				((char *)rte_pktmbuf_mtod(bufs[i], void *) -
> +				 sizeof(struct af_xdp_rx_metadata));
> +			*RTE_MBUF_DYNFIELD(bufs[i],
> +					   timestamp_dynfield_offset,
> +					   uint64_t *) = meta->rx_timestamp;
> +			bufs[i]->ol_flags |= timestamp_dynflag;
> +		}
> +

Why does XDP time stamp need to be different than how other drivers
already do timestamps. See AF_PACKET and TAP device?

Should not be driver specific here.
