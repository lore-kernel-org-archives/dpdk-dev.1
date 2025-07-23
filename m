Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B5C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 14:39:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 038C640DF8;
	Wed, 23 Jul 2025 16:39:00 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 735EE40667
 for <dev@dpdk.org>; Wed, 23 Jul 2025 16:38:58 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6fad4e6d949so28438956d6.0
 for <dev@dpdk.org>; Wed, 23 Jul 2025 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753281538;
 x=1753886338; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1IfX+IjIWaLda5LUm8fz1u31pgfxgRa7dTGDYTBGpM=;
 b=ZG4Eq7Q1Trd+VNhbYdCU8yTI0/nSRGDoozyJaV6/YuxNOqXGLCQhpTqYAz5CHTkajj
 4QZfXMS4CyCzLJqQ0w5sbGs/TVMzKCTzugy7HiNkhUBWoNagbCaHigI63XgLk+NoiGhr
 686fTfxDgtJ2WXz9VnqQi9HtF6Iv2yvtIJi6gaPC+wxF4WYmxgdln6QsUYkf/DUlnFqf
 XOl3yRzAy7w4vyjz8Hd43qpsJcDAY60YV5WBVgcq/QNMCYb4sJX1gAQOWrMtLXXnmUAm
 sZYAKOM/JSXJLd2F6/g3wBcDb8hjcxuINNxmoaPRwLqhnSiZvoyyDVI4vRdeDHrks/5y
 W3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753281538; x=1753886338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1IfX+IjIWaLda5LUm8fz1u31pgfxgRa7dTGDYTBGpM=;
 b=BCn0XZ8tf2+CCUXec9eO2UF7BVLMLLsR4ozU7Exb2dgWGxyNNY9RZyMyRGiCl9I71J
 CMk7veycrDfUTwe6fAbCjgkRzUD69WaLFso+WnkHgiKDhF2rnlMKs8vzIdHY4S/moWEF
 Pn/iM2EiGYhWOgUgfhL6UzSGQskMPNvZTxpfEGQblo+BL/6XuRsJhPp+UL1MVZoDoDw4
 Kv/eAuvV8vZKe+QuofEfoPwH7NTR9Q7HMWRWpY4szLis9821zv7HWcasHPXEMbbT7T1X
 YeRsVBm9n8istKmP/lgCpCFfSoLpYzSuZfz7t5GSMIVV6JFdZZGqv87zBFtjZNFVhIn+
 uoaw==
X-Gm-Message-State: AOJu0Yxj8t+/UMDM4PdBLUAXZry5nZnAlncEiMDcnW6v6QMi2ffZ1SSy
 f61mmGFFV7QZnfROZ5Emge2+NWEL7GOLuoZtnucqOrWWgt52s3lXhoP5/PoQHOkFj20=
X-Gm-Gg: ASbGnctuzy54OYBkmW6xEEloiovJn/ko1BRW5mDAHfa1sIDGZTwdWg/vnyJphBPKuCw
 oFZ3s9dRaZQFCH2tVZAnYQ0blpnimfREh0yFrA34Rj4RKxMXiBKukQR96lld8Yck4lhyEXUYzli
 ufcNU1fm1IrTbxOL0zDCO2n47mCf67hfy/vCK/8CY1YUu/VjYtU3W1h2l3MUyYQWM2ZFKBvxeVN
 Km3k3dNl5UaE26jIBusEP7Lnvcym5OCi9oQO5P4SArHkaP1S/0uu1rYUNtN+gjPfNdcYAUo3wK3
 QV9eqHC1ElmoNKEYv9vR9sM8zz6XdXQNXZzMahoqDKXl8vprPXD+uZVreRg/FkmOGXfJnsVAx2J
 rGTTNnbFUpaIo/d7nuhM9hmam/3fEXjW7P034Wkx6F8RJpom52vrCZGe/ojdef/7AliIFmr96f6
 mHtlEI3jvaRw==
X-Google-Smtp-Source: AGHT+IGONOmzU5jFy+70jAsYlgV1aVvE+QDrJ6epVmU2NdZWY0Sur98LQMRViqPmzURP/UhCPPm2hQ==
X-Received: by 2002:a05:6214:5084:b0:704:8e40:c163 with SMTP id
 6a1803df08f44-707005079b7mr48291736d6.13.1753281537526; 
 Wed, 23 Jul 2025 07:38:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba92059sm64922976d6.83.2025.07.23.07.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:38:57 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:38:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 01/13] ethdev: allow start/stop from secondary process
Message-ID: <20250723073854.1dadcb07@hermes.local>
In-Reply-To: <df249c62-2e2f-69b3-b830-de9b4ee44800@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-2-stephen@networkplumber.org>
 <df249c62-2e2f-69b3-b830-de9b4ee44800@arknetworks.am>
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

On Wed, 23 Jul 2025 05:08:04 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

>  +
> > +int
> > +ethdev_request(uint16_t port_id, enum ethdev_mp_operation operation,
> > +	       const void *buf, size_t buf_len)
> > +{
> > +	struct rte_mp_msg mp_req = { };
> > +	struct rte_mp_reply mp_reply;
> > +	struct ethdev_mp_request *req;
> > +	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
> > +	int ret;
> > +
> > +	if (sizeof(*req) + buf_len > RTE_MP_MAX_PARAM_LEN) {
> > +		RTE_ETHDEV_LOG_LINE(ERR,
> > +				    "request %u port %u invalid len %zu",
> > +				    operation, port_id, buf_len);
> > +		return -EINVAL;  
> 
> A couple of lines below 'resp->err_value' is used to set 'rte_errno'. Why not
> also set it here then? May be I'm wrong. Or may be set it in (ret < 0) check?
> 
> > +	}
> > +
> > +	strlcpy(mp_req.name, ETHDEV_MP, RTE_MP_MAX_NAME_LEN);
> > +	mp_req.len_param = sizeof(*req) + buf_len;
> > +
> > +	req = (struct ethdev_mp_request *)mp_req.param;
> > +	req->operation = operation;
> > +	req->port_id = port_id;
> > +
> > +	if (buf_len > 0)
> > +		memcpy(req->config, buf, buf_len);
> > +
> > +	ret = rte_mp_request_sync(&mp_req, &mp_reply, &ts);
> > +	if (ret == 0) {
> > +		const struct rte_mp_msg *mp_rep = &mp_reply.msgs[0];
> > +		const struct ethdev_mp_response *resp
> > +			= (const struct ethdev_mp_response *)mp_rep->param;
> > +
> > +		if (resp->err_value == 0)
> > +			ret = 0;
> > +		else
> > +			rte_errno = -resp->err_value;  
> 
> By the looks of it, this check sets 'ret = 0' when it is already 0 and, at the
> same time, when 'resp->err_value' is non-zero, does not override 'ret' with it.
> I apologise in case I've got this wrong.
> 
> > +		free(mp_reply.msgs);
> > +	}
> > +
> > +	if (ret < 0)
> > +		RTE_ETHDEV_LOG_LINE(ERR,
> > +		       "port %up ethdev op %u failed", port_id, operation);
> > +	return ret;
> > +}

Thanks, this code was copy/past from pdump so thats why it was not
perfect in error checking.

> > --- a/lib/ethdev/rte_ethdev.c
> > +++ b/lib/ethdev/rte_ethdev.c
> > @@ -1800,54 +1800,61 @@ rte_eth_dev_start(uint16_t port_id)
> >
> > 	if (dev->data->dev_configured == 0) {
> > 		RTE_ETHDEV_LOG_LINE(INFO,
> > -			"Device with port_id=%"PRIu16" is not configured.",
> > -			port_id);
> > +				    "Device with port_id=%"PRIu16" is not configured.",
> > +				    port_id);  
> 
> On the one hand, it's great that an improvement is being offered. On the other
> hand, one may argue this is unrelated to the stated purpose of the patch. And,
> finally, may be placing it 'RTE_ETHDEV_LOG_LINE(INFO, "Device with...' would
> also work and not trigger a checkpatch warning, but I may be wrong.
> 

Thanks this was from editor doing indent, not needed will remove.
