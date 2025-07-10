Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF40BC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 22:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B00424027C;
	Fri, 11 Jul 2025 00:37:45 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 5FB514026A
 for <dev@dpdk.org>; Fri, 11 Jul 2025 00:37:44 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-702b5559bbdso8259146d6.3
 for <dev@dpdk.org>; Thu, 10 Jul 2025 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752187063;
 x=1752791863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmYoWhbvElnhJ5aW6UL4e8Pe3pKpEy4PSA+xJyT5nhQ=;
 b=uOwBxYkiqn1GOpjuVHqg3LOFgdV0cRT9yVxoLC3HKimBXUVB8w9b1DrGeHEvafbT0a
 XvUHZ89PKXhdzx7XSoAmTe64+I1s7kyh5/w6useDYc7LtcTfXUV1DVZEnSVePviu11uH
 5VezgH8M2jZpxMZf1NGBGGpYRNxVMg+k3GU8jU4kmmioEzCdrGDGdIMthhViRJwUT8Mj
 T9YkfHlqMf1GMzp17G2yxceYx58vjkdH6Y0+Ts/jt2u/0O9vk7VICElBdAGqIBgFO5z6
 Kk9a4/uam5dYu+k7Y/TaOxM+nzm4KIXiTpE4S08hPjgZx8eWgXMrGBP3rQRwjUkZANTx
 OZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187063; x=1752791863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmYoWhbvElnhJ5aW6UL4e8Pe3pKpEy4PSA+xJyT5nhQ=;
 b=K21SwXyj6KDyAn8zPmExjL+KSLtB//zuLzRk8ZSx32Rxry/CxdTta9eFTK6+8076SN
 Ya0g2VJ/5PbRAd5EILA8TfStqW/4VOHN77kzagTLdMgQ/643PY/zYJ4wGT8+6uh8kNwt
 qnKNj4LBX+pwKiWLFuhgb6h088DRfugHitLtAJAOxrPnqZJeUnkIKE6cT24TsE+0uEo8
 fe3GxjrLDOvkDwNzqFgkX1ZPl8Y6pcrbOz3lnpRkVgX2qGhkEsl1rLc4cIkxu6z4tSSs
 KLfFTvApyPf00wENykM9lDWhezzf74oxBq8PvhcOF/tfLxaNi/AvCFiHH5/b65miF+Y2
 WQ2A==
X-Gm-Message-State: AOJu0YwcO4IEUU9PRsjgJsArxf5IxO2Y7V+Aq9pzR46vZ1FuBJGIxNBl
 MlYvYvc0tP9XRGCbfxzIRuO9RXwYJRe37RCrLLIPB9sOl0f1LgNjh3eX49Y7Wf4VVYw=
X-Gm-Gg: ASbGnct5U59JweFPmwyAUoz5bGUFi6j89ljoAi6IIs7lPkMC5abzhv5zE7lRqZeeYe1
 0Skm6UErNdiIMhq16wGYA8tQn+mw6CfU4TPJ/zsYl3p6QNRUXrL9oVJKd4yNna/Zt0eUaJodfGo
 YV7t8fkD8mAxWr74X0q3JbSXT9nZAE/J58Puv3eyiAealrdAWanr677u66IR5xOcFVQ9yh+oBid
 lsMVxT2G6CoqjUdn+DsobEhtGWK5cvsQsdCQcF0sORAK3I20aKZydBFBUDYywuwn3666it2E4gp
 FfjaWITWGgalHTn6EwRrPeyENo3KYFXPVpNn9SY0MWMmPx850pFhbj3gEMp+Xj5dRBwrJ0SaepR
 PpoGn5EhUHG0M+Y45uUVABrM84miyVzyIfOkKuvwUVwIP+ozXcPjQTzgD2fZ5CII3EiA50bLoGP
 U=
X-Google-Smtp-Source: AGHT+IHmYiVwPUqdmoGmEisSNBgLYaFzwNGAfoFMWf0jcsIZ6/9832hFwOpbUrQoym3tn2AoczdJxA==
X-Received: by 2002:a05:6214:230c:b0:700:c179:f57c with SMTP id
 6a1803df08f44-704a431cb05mr15745846d6.38.1752187063533; 
 Thu, 10 Jul 2025 15:37:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d71424sm13220346d6.85.2025.07.10.15.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:37:43 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:37:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v8 1/8] bus/dpaa: add FMan node
Message-ID: <20250710153740.627f429f@hermes.local>
In-Reply-To: <20250703053743.3710482-2-vanshika.shukla@nxp.com>
References: <20250703052558.3700573-1-vanshika.shukla@nxp.com>
 <20250703053743.3710482-1-vanshika.shukla@nxp.com>
 <20250703053743.3710482-2-vanshika.shukla@nxp.com>
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

On Thu,  3 Jul 2025 11:07:36 +0530
vanshika.shukla@nxp.com wrote:

>  
>  		/* Create device name */
>  		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
> -		if (fman_intf->mac_type == fman_offline_internal)
> +		if (fman_intf->mac_type == fman_offline_internal) {
>  			sprintf(dev->name, "fm%d-oh%d",
> -				(fman_intf->fman_idx + 1), fman_intf->mac_idx);
> -		else if (fman_intf->mac_type == fman_onic)
> +				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
> +		} else if (fman_intf->mac_type == fman_onic) {
>  			sprintf(dev->name, "fm%d-onic%d",
> -				(fman_intf->fman_idx + 1), fman_intf->mac_idx);
> -		else
> +				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
> +		} else {
>  			sprintf(dev->name, "fm%d-mac%d",
> -				(fman_intf->fman_idx + 1), fman_intf->mac_idx);
> +				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
> +		}

Your patch is ok. But using sprintf to create device name is a potential bug trap
since it could over run the device name. Please use snprintf instead.
