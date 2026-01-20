Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A118DCA5FA2
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:12:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 899F540E0C;
	Tue, 20 Jan 2026 17:12:32 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id EA4AB4026F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:12:31 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so48201555e9.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768925551;
 x=1769530351; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ayq2WaosOp1OSEPMLE7Q+5ZGQwN4SuTxSCZvVXOkCok=;
 b=dSOM4aGHModCZ1p+KVCKaO3gLyz3Pl11lQcSrytBiIbuQAsYnPgF3gtfCaGyPDeU8b
 GUcqJFPwPFVftZGCgG+es0IU+hT1YiIo936GK5vVGinbE7kdu+xGVgiYbXPLfDSjJoWh
 SsHo/UAe6OQtQs0dCgGCryV7Sw5IJRyr4eERk19nY0SokOrsUTg6XgiPAgWz9qCgCQ6V
 CYB+e6XvJtGkfT7Hxck2SAOo6q3U3yRzPO60UwYjP+34lTAfw5pvM9c1K3ScNJlxXaqM
 6gA6S05oCuG4qgQ5uwK9VNPOjCG2gxqvfgAZCc0EZY7+ySx1ZmQY000cgXs+M5KG9J93
 zRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768925551; x=1769530351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ayq2WaosOp1OSEPMLE7Q+5ZGQwN4SuTxSCZvVXOkCok=;
 b=TI22zjL2haydeocBuOKIQbr1r8XTzNt6aa7zwhZPz/NNJdBPxlagr2TG+pS3+mV+GH
 QjW+jd3OIvSxnGTUvKXrI+fdxV8X0DuRbFCz0Dj5JOO6s+dP5MbyTJgDJsKH8cIEzNN7
 txFvPWxZ438h99XI+W3mWh1RFEEIu7EPm+wjiluZ9AzzEz89w7PBgHYdyePBbOSbP3jl
 IOyVE780QfyvkLzh+4Sxx2pTi2h5mpeo7a1pHB455kyvzYw3Gr7TELLUxFsmqjSVFhqt
 BDM8vBkhY56HhwjurHu+E3/AbGWq4Mah2ryhzpXXe/sNb33qMg0BbWKR5IfRMfmYCEbT
 zyHg==
X-Gm-Message-State: AOJu0YyThZjunJcztcF2uiTOfLEcJIvkmAkxkC9PJRejZzQKaX/ImOq2
 ovda4/0cWmk8PxNybAUSvNXtV8aS4+9f2kqnC0g5Pjpsgmt0iPAKtfLB9jp5HCvUAAGRnxpYApi
 0dyXN
X-Gm-Gg: AY/fxX6A8oxYU6bwkDZuFq9IO+d5VsnHKiEluFZmiuPk9O9rAEe9RMUPJtgct44nV47
 3SJONXQMRSkWB2p7sNz2dCzOPjP/AgxlF342GIjLP6Yga/55e1NhVOovQrKZqgI4xuuOkk2M/y5
 lYolrpg9UHEsdt7jHrkh5P5eY1NStKmiUxNGXxgNBQ+qsGyCR2599EZSATFLaNIcLwo0tPE8Ug9
 2onoReT7GnjKvNJIuS3+9gTZzZb2kpkjBST1EKcxwK8TLAh/gISlafB6W0RmNxu9afa7+QyL5Hg
 UMLLuR5OeQuwcm6llw4RcwNZyMC4Mp6RWJ8O+IQBNqNyHy7KygbP1vCq/fToO4LzMiyOpuVsjnC
 TtJ2WtlrsoA8UXgYZqWmCi8aXSQAviEWVsS8ePAubjlOFT/G2edFgV5rRopWW6TeIPETXwYREZj
 vp3KLWq2CQzNV722vVs+ty8F33byQzKfcBHPibPK/veL3BMsvdrwAc
X-Received: by 2002:a05:600c:871b:b0:480:1c53:208b with SMTP id
 5b1f17b1804b1-4803e804669mr37875935e9.36.1768925551428; 
 Tue, 20 Jan 2026 08:12:31 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428acd0csm309557555e9.6.2026.01.20.08.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 08:12:31 -0800 (PST)
Date: Tue, 20 Jan 2026 08:11:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Martin Spinler <spinler@cesnet.cz>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 4/6] net/nfb: use process private variable for
 internal data
Message-ID: <20260120081129.69b95583@phoenix.local>
In-Reply-To: <79b62ea1ceadf3c0d5c6e124715e12f429cb8f35.camel@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260116152057.1456380-1-spinler@cesnet.cz>
 <20260116152057.1456380-5-spinler@cesnet.cz>
 <20260119161351.20d06a34@phoenix.local>
 <79b62ea1ceadf3c0d5c6e124715e12f429cb8f35.camel@cesnet.cz>
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

On Tue, 20 Jan 2026 15:13:58 +0100
Martin Spinler <spinler@cesnet.cz> wrote:

> On Mon, 2026-01-19 at 16:13 -0800, Stephen Hemminger wrote:
> > > Internal structures of libnfb can't be shared between processes.
> > > Move these structures from dev_private to process_private, which allows
> > > secondary process to correctly initialize and uninitialize the eth_dev.
> > > 
> > > 
> > > diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
> > > index 917b830283..09d4b7da5f 100644
> > > --- a/drivers/net/nfb/nfb.h
> > > +++ b/drivers/net/nfb/nfb.h
> > > @@ -48,7 +48,9 @@ struct pmd_internals {
> > >  	struct nc_rxmac *rxmac[RTE_MAX_NC_RXMAC];
> > >  	struct nc_txmac *txmac[RTE_MAX_NC_TXMAC];
> > >  	struct nfb_device *nfb;
> > > +};
> > >  
> > > +struct pmd_priv {
> > >  	uint16_t max_rx_queues;
> > >  	uint16_t max_tx_queues;
> > >  };  
> > 
> > Where does max_rx_queues get populated in the secondary process?
> > What if either process calls configure to change number of queues?
> > 
> > Don't see other drivers splitting structure here.  
> 
> The NFB PMD must use separate handles for each process (each process
> has its own FILE* and mmap handles from libnfb). However, some data,
> such as max_rx_queues, is constant and can still be stored in shared
> memory (and inited by RTE_PROC_PRIMARY).
> 
> The pmd_priv is stored in data->dev_private, so it is shared between
> processes. However, your comment pointed at the opposite issue, that
> the nfb_eth_dev_init() assigns to the (pmd_)priv->max_rx_queues in both
> process types (duplicate assignment).
> I will fix this by moving those assignments to the RTE_PROC_PRIMARY-
> only block.
> 
> By the way, this partial diff shows the struct pmd_internals being
> split into the new struct pmd_priv. Semantically, however, the struct
> pmd_internals is the new one, is newly alocated and holds the
> process_private data.
> 
> Does that make it better sense now?

Yes thanks, you might want to add a comment for future readers
