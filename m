Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441BF483EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:50:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F6D402D6;
	Mon, 23 Mar 2026 20:50:55 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id EE8E940268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:50:53 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2c0bb213b16so8025891eec.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774295453;
 x=1774900253; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neaovkKIn/ZR0CYe0/9qJOYahLsxP+245lZJ5lUC3+E=;
 b=SqRcED6/J/AYoTRno+jQPDDtNYCGq6nD7NZ4URA+ynorFL/sP+86KmKpDXg0Rcl8Gg
 Eafboip9yonsYoRB7aaV4fROJjwMXSj859bbDlXteZmrJpYLHSKrYh/Ns1Qsc8/glcMx
 GFNZW/Vy9S7ZeiSorP9O3TuO1nHMLCGOF3aq1KMWIu7ms7udnoAN7fOAevcRBysmPfWu
 bvf6mFMF+3g1yK9R+Q1JfVlVKyFrHNLQM6VaqEAy3sPh4ff740fGihZm3w3IZJWWRGRo
 lSJaV26isznO/xnuDmos5wDKKCH1xvuuZs1IaoQZXLdKeUsD2aUNuRdOMODe7y2EB1Bi
 sJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295453; x=1774900253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=neaovkKIn/ZR0CYe0/9qJOYahLsxP+245lZJ5lUC3+E=;
 b=MLJmOxxLL93hM8j6Ra3X7nmIjBBnHEPrR+GRwEvMfb+s7MZYC3xa5DpPp9y/kbc0+T
 /9SxSXhpWwn3IzLEQgxh9ka6W4UivuC/M+lsCYQJdfsgdzWHDz64r1gdewJxeOeUDRxC
 VA59LP5cK5tXzB08naFOqOY2duJU42lpMuL+/cSCZc6GMTF1NW5NeEp+7T55r990fMdY
 3RdQTcAyX6ME54t3GRw9v19TGnmWD333hfjXEeoQsCWTf0hEJ/a6ln58pPs9GujMlKV/
 San2BCjC/KoHSJ2COZkjfP37TdDkRFpd3dYrpZ4iMkFWBNSREyxvUfd9lgZTOQ/rrjjU
 w/dA==
X-Gm-Message-State: AOJu0Yx4eZnWWF7zlstwe+X010VjAD+wzCKO18ShYnXT5OvGzFeMiRXP
 Onr+kkIkvuQeLzQtG8jB0E9yI7dedgoC7Pw157MKU/DR1Gc+hzXADLi2KWrvIo/yw/I=
X-Gm-Gg: ATEYQzzQLanC47f8SmQPidUU7+FL2tz1uoHh0jTQ/rLXiRDnaXsNrCPyaBPGpjuvaid
 8jj8CBf1v3gQbluc0R3xt9ba6AwnsgvBL6GN8jU6vL9u7oE1eRwdQ5IKfO7jfxb88/NT1ipgWin
 lHg7QWPRft65WSyEujll3HFVaCEmF1k0dGU2EgeMkEhAggRIp+XtV/Y1Tg2OCAOJ7T6K3WUT0B+
 glx9xUYvZI6lAGoA52QiEKlomlc4k4CfFsjX2b4LFnQopg0NEevkZp8yYP2Pd/TkkH8UcDNMKA/
 XYRCfi1CyUYBdEK1N736/DUNyEiwrgfB7pbrhQblAGmd7jxHhhEFSMfkiUmwGiE/WO/3M4cabmB
 HKqPMJNXe4L1ZuXrVkfOKg3K28F7TSS85klBfhtYg034EaQ/Ld78GKilGQKmigJgSWUUJyc5bhI
 Lk0nzJO6sFZya1y2VCTURfz0l8reiIMSLqajc=
X-Received: by 2002:a05:7300:5707:b0:2c0:d690:7b9 with SMTP id
 5a478bee46e88-2c10970eb6dmr6818173eec.22.1774295452732; 
 Mon, 23 Mar 2026 12:50:52 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14caf3sm17745383eec.5.2026.03.23.12.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:50:52 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:50:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [PATCH v7 7/7] net/hinic3: use different callback func to
 support htn fdir
Message-ID: <20260323125049.1ae8d1bb@phoenix.local>
In-Reply-To: <20260323080455.2699-8-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260323080455.2699-1-wff_light@vip.163.com>
 <20260323080455.2699-8-wff_light@vip.163.com>
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

On Mon, 23 Mar 2026 16:04:50 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

>  
> +	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {
> +		rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
> +		rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
> +	} else {
> +		rss_type.ipv6_ext = 0;
> +		rss_type.ipv6_ext = 0;
> +	}
> +

Overall AI review is good, but:

One issue remains from V6:
Patch 7/7: net/hinic3: use different callback func to support htn fdir
The copy-paste bug in hinic3_init_rss_type() is still present.
The hinic3_rss_hash_update() instance was fixed but
hinic3_init_rss_type() still has:

rss_type.ipv6_ext = 0;
rss_type.ipv6_ext = 0;

The second line should be rss_type.tcp_ipv6_ext = 0. 
This was reported in both the V2 and V6 reviews.
