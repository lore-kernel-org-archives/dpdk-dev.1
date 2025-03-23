Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACA5C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 16:00:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E9E140277;
	Sun, 23 Mar 2025 17:00:39 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7E11D40150
 for <dev@dpdk.org>; Sun, 23 Mar 2025 17:00:38 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2241053582dso40951755ad.1
 for <dev@dpdk.org>; Sun, 23 Mar 2025 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742745637;
 x=1743350437; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWJw++/8LxBQ9MzSr/xdjwom/BpoteuUJr4WI/mnLJI=;
 b=N4+Rn6mJgmQ7mTB9M65RniK4oFSHU5euGvAPZhQMu1Izr8Gy9AajqEng7Fh6sMp56b
 2bYkbyZ0Xph6JHW5MEAN97ILrcnMHBUBfix+32DXunmXoLfpMyH9huWLAZUQnKjKYR5w
 AZ+X4Mjex6qaRlY764YjmVyXDG3cMt/H5P81XBmRqfl1h1TH/bykLclOtDRmaKj0cfYX
 /9EyNqD0TTp5qt2VegoIAQ13EMgCKpp0G0IYorK7h52dyqDDPjePRSP6A0VxYPYhlr28
 uLVsHhuCGFWHRv+xayIxnj83TFYYnUDYPSbU25ag108yMFyhBznacbZkxtZQfnzDSeTX
 Gbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742745637; x=1743350437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWJw++/8LxBQ9MzSr/xdjwom/BpoteuUJr4WI/mnLJI=;
 b=fDm1W3Zn1uQgGb4zGwkFxiov03e1pS7GatswixDYaJIRI6yy4xNErKLlGgSGZ3zunq
 f2MPYjJhqxucGXVVH9DxuKVfch0fs/1dO2nkCi1wQ2ZLxsW79CvaPaOTOuiMhtvrCFIO
 w1swKAwS064EEa8zmWoVpkr3yoI84/KDnMYNgYNo/66AfVOXNRB5hxVQcYU64eKEtZE9
 1Y6kQndkJ78iTvxEUh8smFQT/3/QNFrFPFjsCy2E+rvN2dyYCLieCzGJdg1JjBeRxrx7
 BfVVK9/QHz47eZk35KPohydJp/iaOIRU3QhHVq2ctzg9FrL8EjQgV7tnmc1P9wjdkBC+
 mlGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqVzwZHn2baDgZdVKOS6YDGRvJsccRR3w4Ya7iKi/0qleIOI799O5ftLx33SP2jKrlmKs=@dpdk.org
X-Gm-Message-State: AOJu0YzbCnx2veTmCCDDvfPX2UIAPS4IocpOFvUsIzX57rGahtXJ/wvS
 9hRJmhXQ0A00LBFxSGtkx19Pjub/tlxSEDe8+WoypyV14F1fyDl8m8YjPUV02Xs=
X-Gm-Gg: ASbGncvkwNL9j8qjE0jdHMpOD5Fspv/rN71eFkg1+9dN5xcoAnVELOf/APsi7llrgtC
 HoY3AWbQZ0Zb/Xk+eeiGpucni37DhRrQVdofH6uxo1fn/bCCnnOb4fctiAim0AF4LXDvk/NCzTV
 R0HwG7cxbwnJ5qEYBi/aVoLdsigxSt2EMLVCmVsL4bM7uOYqg3F+GjOFIyhKRFlpitAKohsdhJg
 BMAx5C489mYdGKbvohjZEww0RWop52My6Nf0ePwSKhfVFqmrWb6sgMSoxJtKQjwB8y33SOpGg6K
 Ix20p190VO1oUQdC3TTV3w3Vyvl1LR1095ShsiBtIF5w7HOVoSr2IECG+LjiOHn7MBnvTEx0Jmh
 EwB4P019kVu6dXM70JrXU1SP+0ybT0ys=
X-Google-Smtp-Source: AGHT+IH9je5nsc1SW6MhnR78l0idheVJSmSxBwGUauo8QU5d/YSC/geCl/EikLTOal/zf5j0f/WuMA==
X-Received: by 2002:a17:902:ef02:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22780e14e9cmr179811085ad.38.1742745636976; 
 Sun, 23 Mar 2025 09:00:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b8080sm53082045ad.116.2025.03.23.09.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 09:00:36 -0700 (PDT)
Date: Sun, 23 Mar 2025 09:00:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <haijie1@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix VLAN header parsing
Message-ID: <20250323090032.06d6aa45@hermes.local>
In-Reply-To: <20250323122822.90407-1-rasland@nvidia.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
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

On Sun, 23 Mar 2025 14:28:22 +0200
Raslan Darawsheh <rasland@nvidia.com> wrote:

> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
> ---
>  app/test-pmd/csumonly.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> index 5b906eaa53..302cc4cc66 100644
> --- a/app/test-pmd/csumonly.c
> +++ b/app/test-pmd/csumonly.c
> @@ -468,6 +468,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
>  {
>  	struct rte_vlan_hdr *vlan_hdr;
>  	uint16_t ethertype;
> +	uint32_t i = 0;
>  
>  	switch (ptype) {
>  	case RTE_PTYPE_L3_IPV4:
> @@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
>  		return _htons(RTE_ETHER_TYPE_IPV6);
>  	default:
>  		ethertype = eth_hdr->ether_type;
> -		while (eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_VLAN) ||
> -			eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_QINQ)) {
> +		while (ethertype == _htons(RTE_ETHER_TYPE_VLAN) ||
> +			ethertype == _htons(RTE_ETHER_TYPE_QINQ)) {
>  			vlan_hdr = (struct rte_vlan_hdr *)
> -				((char *)eth_hdr + sizeof(*eth_hdr));
> +				((char *)eth_hdr + sizeof(*eth_hdr) +
> +				(i * sizeof(struct rte_vlan_hdr)));
>  			ethertype = vlan_hdr->eth_proto;
>  		}
>  		return ethertype;

A loop like this is prone to getting attacked with a malicious packet.
You should cut it off after a few vlan headers.
Also. what if packet is truncated, shouldn't be reading past end of data.
And what if packet is fragmented, you need to use rte_pktmbuf_read()
