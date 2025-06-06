Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05726C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 15:13:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DFF740283;
	Fri,  6 Jun 2025 17:13:14 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id AD86C40263
 for <dev@dpdk.org>; Fri,  6 Jun 2025 17:13:12 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4a58d95ea53so25093051cf.0
 for <dev@dpdk.org>; Fri, 06 Jun 2025 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749222792;
 x=1749827592; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrU2VFL8R7v6mNI4mlSh98u777ThmxGTLNVGiCP1cRI=;
 b=YL0Y/4011M7r2oES52YjZAyphO+eO/f9iaJ43J3zMwuOIa2LLHrqheLm464tVbdUg5
 OnJqaK4hrgSSJH5XuFgBgzg/pAtpJSHI1JyVHcCUXkLW805WwqBD3Mvimmowc/a0ONSE
 dDARCkaXtg+p7EAgYehnF1W2QDnlQ03SrtkWKaCTfMlXpC6xhukwK66K/FuYk/hTRHUe
 H5chPUwJd83J61AZjYg4gZnzZ37uPrG14L9BpGJFjQ5xy6XJdduvOeXNYgwY3Y3z5PO4
 xUUWLdyvj25fW5WAqCd22mWvdhR+ExpaHS2MRRay5b1NggSIuLYR1uTFIttWX/LvYHFl
 Vfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749222792; x=1749827592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrU2VFL8R7v6mNI4mlSh98u777ThmxGTLNVGiCP1cRI=;
 b=gXP0B6ugktI1Nf2sOAvwSz/BGFU4IKo5bl15Lxx+PPgHt31y9B9R8WntuoWaMuVXzb
 XTrxokeY1c44OD5dbl/daaeLA6zkyLsE9TiiZPBjnVAO7nQjanIgPjOZev4YjI9KF5DI
 F8VAKphEQre9ThY9ppZOYU3gpCqWXKsV8NGh80/5yGGpNg1R8ZFol++hW8JrZjhx2p34
 st5aW80sgtMGJe/JmJelh/DA+rs1FUqivcIGHnsToZMESAGjbLILHx6ZENu3pv/iLYbx
 +N7OKjQwW+PBN5ENPMxOI4yZ7CUNLB9YTUKmGnlfAKOkC+UFAM461rmTm9fUf6pKVAbC
 Pc2w==
X-Gm-Message-State: AOJu0Ywm2SJwruDvtB9CfAPHFsZYVpDoTWe/OcMqSzB1y/CzBn8Y6zRo
 hTV5RvAQkIUEbLmnoMagGPYdMu3/M8BYZeNob9cUR2f99R6QhrS/yJFNfkb3MSsNVi8=
X-Gm-Gg: ASbGnctUgIKDT2BOPYd7MqMS0UN8XHMggWl9RWh6h93/Um9fNOWqWIoeIt4JYW15QRV
 5sH+vTolK/b1z9/+HXJEHPIBtpujUxbZ+8BiPxk0DbSZXK3d6vJM0axwbOC74TavMW4wZh13Ilh
 v++NOXDOX7P/M3lUYdJUqAwNdjal+kzVlk8qLx0O8hVkKWB4AT5ZAVXquHlAFRVNupprZ/vl7SN
 v3kLIj/tYsUTCCox2QN8NUlrHebYPgybN62a9dtsZU/Cp5enbFqRewmznmIgBV+bKFWBwPBdNpw
 WYySEGugVjn5MSgt6/G4ChFgu8dXXBxC06fTxyphJeTsXsHr1eU06P/jqI3ZsQWuUyJUfmWqFWZ
 g1RBCiUOqxIC11uPZkGooPwwXN0GF2m+V5wCZu3w=
X-Google-Smtp-Source: AGHT+IEzazoTp6MobVRTsamZU9YnSYPrl2nVChbFq/EzifZnhG6mXYDmQBmPI5PKMjGsslahid8BcQ==
X-Received: by 2002:a05:622a:5148:b0:4a4:2d6d:80a0 with SMTP id
 d75a77b69052e-4a64b6511admr48481041cf.10.1749222792002; 
 Fri, 06 Jun 2025 08:13:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a611150479sm13854481cf.5.2025.06.06.08.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:13:11 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:13:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250606081308.00b32b15@hermes.local>
In-Reply-To: <20250605230237.36131-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250605230237.36131-1-schneide@qti.qualcomm.com>
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

On Thu,  5 Jun 2025 17:02:37 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

>  
> +RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
> +				  (rte_pcapng_t *self, uint16_t port,
> +				   const char *ifname, const char *ifdescr,
> +				   const char *filter))
> +{
> +	/* Call the new version with a default link_type (Ethernet) */
> +	return rte_pcapng_add_interface(self, port, 1 /* DLT_EN10MB */,
> +									ifname, ifdescr, filter);
> +}
> +

You should be able to use the defined value directly here.
