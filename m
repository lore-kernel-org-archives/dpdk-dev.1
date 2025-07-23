Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A18EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 15:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 441EE4066C;
	Wed, 23 Jul 2025 17:26:43 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9689E402A9
 for <dev@dpdk.org>; Wed, 23 Jul 2025 17:26:42 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4ab71ac933eso54949231cf.2
 for <dev@dpdk.org>; Wed, 23 Jul 2025 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753284402;
 x=1753889202; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTsv3si/6BpibVDxNSivMPBZgvRDfnKe42OrIdq8eR4=;
 b=BhQiGYzHii6gKMCuFf+7njIRMJUt8963s7j/QsPHTP3QmrMh3L8ZDWSxxYGiTBAygt
 /N7nk/LY7AWLbFcDVM29Oue/Ep8rk3q00z96ZCsxAj9X8K7C6NCYx3tw2qn+XINfvwhu
 CjWrVCuBJUVnDzH/kPX4VPrcqEwZ6LOB3Dywg1IYXfOaHPZTPutrdfDRSI7CTQMViHoU
 DijfIwmArMEg0fqVr5ZtJgST8aSsmWifydpnNjnr3cHMOeWY+LyU2TJ9YfOuP4J7L8Yc
 pH9bone2S9kmIxJ26iU2lW+Zl/oFmIaJfLTvJnZHiLP2vprzItMQZlOAOgpyjNQPAqRP
 BQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753284402; x=1753889202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTsv3si/6BpibVDxNSivMPBZgvRDfnKe42OrIdq8eR4=;
 b=kdwZczKQ+XuJNV0W+b37s5+ZZNwBTJsZG5JNLeXvzGlx7noBzWW1llSjzcM1Xoou7v
 AkdzS6KneHHK0sJQJs2MvO7soScHzhhQKL3UPCev03lznD6qRIp0Q3nUmaggzNInV+M1
 4k6FVbulM2OVVqLzLpcc4/iIuZJ5njS+9dIseV4WHm3b78KqNrUUCVPkNh+mi9+Oh/ln
 8kpzFw5zefDIUzL5hwm6ymbjoxMEjVtkvl3Evl2MxDjo7oxWF4EU/43GpueTgd499TJq
 eambaGH6eEX/7wSYDyj9Wdgk3f3egYuPVPB8UYxsPCPdeMQc+VXgpdNLMCjopp8dJ4l1
 +ifw==
X-Gm-Message-State: AOJu0YzV56kyIfQx4zp+a4awPSeGVN0BtMefYGoPCh1lqkJd6vGBE0wA
 kUxmoNQAF5Eu+gKOd7ET6JheRUl9eY+VfqJC/AoWlpkeACYJB30tth+h5jx+HvujbSU=
X-Gm-Gg: ASbGncvSAtA+mmeyI1xm8XJccJZVkShrChKn8F6ClOK6yDPg42B05RbIEd/W1XGPtMe
 6jnS7UPM8VjEtQyZZKu3DyZKOAePSQ1ZU+r0mX9dP/fHVTd20AwAFM/xr5XZI52VUX1v5F1ZunX
 bUTJ8WkIuW1bdXw+PNgV09sSe7BTX8RORCB9TbOtfSnfNaMi9Roraruqkox9gxcmBujMdYcRYie
 cdsAsD+fYoFT8OBmV3o3c4jPwvV9qPdfPrlsj6+HquVMjym9hbI3Xb6Nm0nYQuOXpc2IGNbtm52
 k2gPzhaHD0eZWl1jmYFRtFNxX7yDVhIV+uj/ImqDhlQ5MNCp4d8wsjnDW6D3CCDv+Eju/KaQaip
 YsN6iJ5B17k9fpR0SPcNiQF4pl6H/YX8wg6OKhl/X7SU2QKpO0EMQd1WdRIWZgQgEJZLhLZ9tNa
 Q=
X-Google-Smtp-Source: AGHT+IGRShh3OeFN7RKD4q4EZjgUlkWxKInslxJ/2x0H8zR8hYeHCHO1mLkDY9F+TFDU8FDZNBht5g==
X-Received: by 2002:a05:622a:410e:b0:4a9:a90a:7233 with SMTP id
 d75a77b69052e-4ae6de4e098mr43511261cf.12.1753284401768; 
 Wed, 23 Jul 2025 08:26:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4b44216sm68796751cf.61.2025.07.23.08.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:26:41 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:26:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Thomas
 Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 07/13] ethdev: add port mirroring feature
Message-ID: <20250723082637.2e25b757@hermes.local>
In-Reply-To: <af08b0c8-1bb9-ca64-f62c-61bdc884adbb@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-8-stephen@networkplumber.org>
 <af08b0c8-1bb9-ca64-f62c-61bdc884adbb@arknetworks.am>
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

On Wed, 23 Jul 2025 06:13:27 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

>  +static inline void
> > +eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,
> > +	     struct rte_mbuf **pkts, uint16_t nb_pkts,
> > +	     const struct rte_eth_mirror_conf *conf)
> > +{
> > +	struct rte_mbuf *tosend[RTE_MIRROR_BURST_SIZE];
> > +	unsigned int count = 0;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < nb_pkts; i++) {
> > +		struct rte_mbuf *m = pkts[i];
> > +		struct rte_mbuf *mc;
> > +
> > +		if (conf->flags & RTE_ETH_MIRROR_INDIRECT_FLAG) {
> > +			mc = rte_pktmbuf_alloc(conf->mp);  
> 
> Can 'rte_pktmbuf_alloc_bulk' be used prior to the 'for' loop? I do not insist.
> 
> > +			if (unlikely(mc == NULL))
> > +				continue;
> > +
> > +			/* Make both mbuf's point to the same data */
> > +			rte_pktmbuf_attach(mc, m);
> > +		} else {
> > +			mc = rte_pktmbuf_copy(m, conf->mp, 0, conf->snaplen);
> > +			/* TODO: dropped stats? */
> > +			if (unlikely(mc == NULL))
> > +				continue;
> > +		}
> > 

Both sides could use a bulk allocated array, but would need new variant
of rte_pktmbuf_copy for that.
