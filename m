Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF07C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:08:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9D2C40A6F;
	Mon,  7 Apr 2025 17:08:12 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 66C7D40261
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:08:11 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-22403cbb47fso47382065ad.0
 for <dev@dpdk.org>; Mon, 07 Apr 2025 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744038490;
 x=1744643290; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47roNGeBvPk6HvNqFvQM3g/4cXA8H2PgHJUFanluvrc=;
 b=lIZNb/SDTGjF7hmgPFmiHzPoHwPWPmD0j807x8nlDvQsbZwajqHL8TESUD/QHOPwXI
 lGaCZS2r8bNMM2KVupRkZbh4EtUh7finS0m0gscZUmQxEdnWFI3vcI8ZzEpR/e02qAz7
 U/3Lh3zklha0cEeydVCKc6xLEVDwMzaQQDhRmWl3AE4HxxlMMsO3TNpgeQbV+Ht3vCLb
 Y3hoNifpYsWZBvXBgrqHZ9Sf+7E0I/Kc5nfGtFPl2Wa10VaaTkvNjt4k4vURlvJyjoGt
 Zu0hub4nHBHYoOCBO2ksnYn3BA+Q5YONa+879bRsPEisFpP6MFrW/gjUMPLa2IB7ffOo
 wC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038490; x=1744643290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47roNGeBvPk6HvNqFvQM3g/4cXA8H2PgHJUFanluvrc=;
 b=oKS56z+fpLa3+gxBAPHDuu79U9qzAh3sdVk0lxvfCtyZDihUQ+ablXiJmr8bv5WBdl
 LwARBdZWcwxns2rtwJMvyv6ryWwwxzGrhlgPj+hendvV6XIoVECVaX5TyhhMjQhbArm3
 o4pQkBiaFrgVihcvPkmdCkKZe51TfpdV23Xbz+O3oPH6fxdIKoZfq9n82/h5cEh4dwrJ
 0XlP+xUU3Y/rXz0gfPHAmZhDlL1Qu0qBQZLIifEo80h4Hpb5C5pLgbGELYCgCU6g6wHv
 hu632qxL+Co0f4nw58bYioc6FqyjSZGW2s2h3i0RcMqR5Z6MxSJRPpLu+uBQkMKwdoUf
 oKUw==
X-Gm-Message-State: AOJu0Yxw/bScdyELFQOJP2261NyYWvrhhwyDHgWpzWaIqkmnpmi5atZa
 sQwri5pv0XAMnnUzfmqMHJAn6EEObflBb4gIB0Ea+0uFR0UTszqo1FeiOXmhH94=
X-Gm-Gg: ASbGncvAeoX4BVLZOQ3YfbEOxZ0YwxVlBO19MPxVs2PmQcPACPSZRzMmxPq+v70L3UK
 t5eB3wFBeHg6v4wQVTtnhFa9gbHz/9A9YrF5LfnckW/krJYTSef/qd7DYomyc2kkKomp3+MvKQb
 HmNXu2UX4H8reAD2+KEcCn4W2qQlZ0Hab/StRKHXKbWnuNP3H6Wec0SGf+UNOAWtD8xEYCGAlge
 zH8wkcjaq53wk07AyUryuQf53GEi2Jvo6bvEVOtAzdz+tsBy8PKmBN22eVzfVJIBEv1pRvdj6Zh
 06CSwmk2qg/9mxswunXCSRRhMN00jCGFrvtgb/YaQ2vHfT3Xpy013ohfgDcTPOyGwrfC9E+YAH9
 24wRXbu/f93f5NB2hHZT/
X-Google-Smtp-Source: AGHT+IGmem6nUts85febFC4gr4tGA+Egvqj5AvRp/7h+TNsWwtgXmftVkNXGQLDJcQGZ2PHuHPNYMA==
X-Received: by 2002:a17:903:3ba8:b0:223:6657:5003 with SMTP id
 d9443c01a7336-22a8a8c9b63mr202003815ad.32.1744038490494; 
 Mon, 07 Apr 2025 08:08:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e4a7sm81993135ad.133.2025.04.07.08.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:08:10 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:08:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] net/pcap: fix indentation and numa node
Message-ID: <20250407080808.29b83ec8@hermes.local>
In-Reply-To: <Z_OgKaEXuxqWALbm@bricha3-mobl1.ger.corp.intel.com>
References: <20250405153623.200771-1-stephen@networkplumber.org>
 <Z_OgKaEXuxqWALbm@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 7 Apr 2025 10:51:37 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Sat, Apr 05, 2025 at 08:36:23AM -0700, Stephen Hemminger wrote:
> > The process private data allocation was indented incorrectly
> > in the source code, and had unnecessary cast. It is better
> > that the data be allocated on same numa node as the device
> > structure.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  drivers/net/pcap/pcap_ethdev.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> > index 728ef85d53..aefa74c7be 100644
> > --- a/drivers/net/pcap/pcap_ethdev.c
> > +++ b/drivers/net/pcap/pcap_ethdev.c
> > @@ -1208,10 +1208,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
> >  	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
> >  		numa_node);
> >  
> > -	pp = (struct pmd_process_private *)
> > -		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
> > -				RTE_CACHE_LINE_SIZE);
> > -
> > +	pp = rte_zmalloc_socket(NULL, sizeof(struct pmd_process_private),
> > +				RTE_CACHE_LINE_SIZE, numa_node);
> >  	if (pp == NULL) {
> >  		PMD_LOG(ERR,
> >  			"Failed to allocate memory for process private");  
> 
> My concern there is that by forcing the numa node parameter, you are going
> to make it impossible to run with memory on the "wrong" numa node.
> Admittedly, this is less of a problem with virtual devices like pcap, than
> physical ones, but I still wonder if, on error, you should fallback to a
> regular "rte_malloc" call to allow the allocation to succeed so long as
> there is some hugepage memory available somewhere.
> 
> /Bruce

There already is a numa_node parameter on the eth dev, this was just trying
to put the private part on the same node as the existing eth dev.

