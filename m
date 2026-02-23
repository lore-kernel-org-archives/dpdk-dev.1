Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888CDEC1113
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E64402EF;
	Mon, 23 Feb 2026 18:40:10 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 9A90D4025E
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:40:08 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d19bfe1190so3834508a34.1
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771868408;
 x=1772473208; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95N4RbviGqf9gyepjL6CN78d8iE6aiokF3JGOasWYYU=;
 b=qql1yuqYjQXDR7WhJpoE2NHqwG3c1CkXOOy3FiyVco9xuIgNh38qcGPh9hRNhPuH9y
 C9PMIu/35xkB+/x8cEInb6SeDemSB7zDjP8E4KTl6o1hc2ClUvDy4r2fbGTblexHVR5f
 sMEQf9HvdylaGqckwCN6EkAxyEak97FidycDgWveV0/uqYgOL+P1D08k9hV898hoUIzQ
 Lzrob1CXUXVP9hvZ7LzX/B1By85X3FOZP+McAXTmsziBQradKRzYXxhTXjVyxw88LF5n
 Dd31SpUG04yNzCMPVHJ9KbIsE/Cf/qjCIabgr93SrzTUAcdWpBRC3LkNVQgJltMDahZN
 tovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771868408; x=1772473208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=95N4RbviGqf9gyepjL6CN78d8iE6aiokF3JGOasWYYU=;
 b=PymBXB3gHT5YD1CkqGCi9NBJmbWgrow9lxcdKgVbKOBz6uVEJw6d8O4wB+QISsNQ9J
 SrUVPfpvlezBUILPhalOvBeUh48q0kZIdkeSbVVd0kHtYn+t/ND47CrNVFyufF9Bp9KY
 t+8zyuB67i+t1uvz/sOEYQJg9kKYstNE1z8zgkrurnRzAPwp7kBuZDYLU1+0vIuaHLga
 QUdxS5sxrlM9GABi2NpBsm/y5KgwA4eIJNWwgqVpN6i3vzynHRlnTMzWAhe0WN5g0ivd
 Dyn5PvpVXUfYNo8jEuOXw7iyXiQpZXbYe4gj0Go4TSiNyvlpbIqellevDrRyoT7oKYap
 cqdw==
X-Gm-Message-State: AOJu0Yz5gV2KOK/+RF+UPmjMvXKFKbkSRoahmXjfmtpgecWHeozSv5KX
 VjrEvJFo87MTQLdgCH+RvnkitkDaoktrc6XJ4DCQlBks8pGWShx2ZxSJzzYaa1PuJLc=
X-Gm-Gg: AZuq6aKLRF26l82W/hoyqqzsHAnhhDv3DFw62DeYeKIUktLg7Gnm+rfWAn0Xr95Fn0t
 rmocPsSosc14R1yLWVyexDFYwjz3SgsgKxdXx6E5FzX4tfO8Wv/pCgtrZetETqzQqtFYINPTbyI
 FMXgpegIhs4E/VJo2tUcJeA2KjBEr+QAkb+L75GjLfG8OOLTPMhXJd6WeX2mdhPm5h3zIdlhNL+
 15VFcqsOPwEQ6eCamqM0dspFtu1sbJZBB8jBoNiE2xHronI0Hmd3HxyJg6s1FIpnA+lFfl7wGRe
 3/+PsdDW7mZZnQQQ5odCUQALVHhbkUAKFkqE1qy/SE6uvjYkWSXdpYaGwHb/xPjPgbkqURkxpqW
 tOW4PPNvMMDWkUKG638wVMH3GUwKyNxvy4+kP/N9abvLxf6Rj8mG1OxTjEEt8Yz12gjw82Ne5DL
 Mlu1HmJl0x7TXtzWPYdR4Of8CXQRGk0P8FIcVOImksBfMpNmyhX+qzW97Sr8xCBTE3
X-Received: by 2002:a05:6830:90b:b0:7cc:4d72:586e with SMTP id
 46e09a7af769-7d52be3bfb2mr6755503a34.9.1771868407690; 
 Mon, 23 Feb 2026 09:40:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04c637sm7591742a34.19.2026.02.23.09.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:40:07 -0800 (PST)
Date: Mon, 23 Feb 2026 09:40:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2 2/8] net/netvsc: fix race conditions on VF add/remove
 events
Message-ID: <20260223094004.445914ee@phoenix.local>
In-Reply-To: <20260221024540.659098-2-longli@linux.microsoft.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
 <20260221024540.659098-2-longli@linux.microsoft.com>
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

On Fri, 20 Feb 2026 18:45:21 -0800
longli@linux.microsoft.com wrote:

> +	rte_rwlock_read_lock(&hv->vf_lock);
> +	vf_dev = hn_get_vf_dev(hv);
> +	if (hv->vf_ctx.vf_vsc_switched && vf_dev &&
> +	    vf_dev->data->dev_started) {
> +		void *sub_q = vf_dev->data->tx_queues[queue_id];
> +
> +		nb_tx = (*vf_dev->tx_pkt_burst)
> +				(sub_q, tx_pkts, nb_pkts);
>  		rte_rwlock_read_unlock(&hv->vf_lock);
> +		return nb_tx;
>  	}
> +	rte_rwlock_read_unlock(&hv->vf_lock);

ok, but read locks not free. It does incur an additional cache miss
which may impact performance.

Might be better in future to have some form of lockless access here.

