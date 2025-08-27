Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995D5CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 16:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B744029E;
	Wed, 27 Aug 2025 18:15:14 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 3581540292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 18:15:13 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45b618e067eso7626145e9.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756311313;
 x=1756916113; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEmT/vFn4FvkidipENOaMqjLmWq3xR7MsO7/0ojaqGw=;
 b=X/5hPmiMVfTBc+YNrWd1eYPwX2SdJDjVORn14MAEo9q1JJVEH0hWPPHjnG0KZfAtsh
 hWTPHVDsYZAVmdeEiXUV9zPgvabMZZKBTvqkSuH77jdLR64Ezy3QNDtXXnUOJNwW90+P
 r4VhULvni0nC/a1VKjitedRHiUTQslQK9VLoU3ZdJIqUAW2GlVlG4k4u87BzHJp1Obkw
 45D1TxrZOrKNFPf6kfwJnS4HNuj6pFzFD0swZilpIIS8cXAq20Q5KKGkKTPwU32qcg+e
 C/NqOgOk36qXVc/65wk7SyFvRlYsNc3xgki7bQTv9I3OhVq4u7hVk57L/b+SfQVLraFj
 Iz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756311313; x=1756916113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEmT/vFn4FvkidipENOaMqjLmWq3xR7MsO7/0ojaqGw=;
 b=ez14TIAk3aO6zYRyujz4unyJaO5QcvRvN9XbjXXdCF0XiVVrD+dpRtnG6WQmKs5Pid
 e0Yo358LKbk+E23PwDAfh13Mg64quHS/tT0TSeuIe9aU6sDoS1/kBOLORSqah5tx4j1l
 7L7HroPQqY1LnL9fkbWzgwao4eVK7a6073yqamiDD/kBc9ZiNPQt6PnNE44bGQ8adW+f
 C8Mcl8dpGyZYGAUGaB4DoFvT7bEu1qYTKR0zFeehpbH12VfX+4V/2Li0ysSwapg4naY6
 5u7YzIJ8AR0PvePVqL2LVvAcw8AhHbqXOQaqmrnCYM0k2M+UsFjkC6a0W4cfa5VrtImW
 7ETw==
X-Gm-Message-State: AOJu0Yy6kf1xnszPcDFAJt+/ULqfJvO2iXgNps2NSBPabf7khLqUV+ej
 XktQjtphE1B6L0kYYHNu6uXZczXQpSsfg+iq7Q+oKIiVnUpjAPpPU8AYk40418a5fDk=
X-Gm-Gg: ASbGnctgAg3qHmxAXdK2zSHI+WUrQ+IKqXl1GTujjZcUy2J4C7/ymVZDQ8ZbK6wZvCF
 opBCoAyYrVrGYP9zzw9S5CblH4p/gUp7aGh1yjdiOwcxNCXLOCFwAWkOblSsoi9TLQfJYRfB3b7
 rrI7i4OqFsepzz2vWyPD14OoRmV2zf+TWrjVuzqtSwEF3L7gNNBdCm6eAsAPXMSFJDLFK710X0l
 7adU/l8ScgOkzgZHbnbFEORxl1MPAKZxnO3Z3bI/9rf2bVXjIrIDkrHjNfuBUZmSFtICxJnI/Z4
 uKRyooX/soyNB9X8YKHIjBB993nCexeuqzlvI7C//lp730nPFrISrwSXV7ngXpR3WD+Q0slGUc8
 jJyc+lw6q0M0PP4xxFDR1pYL/Dw3dzNst5vNrmaCJF0RMEZFYyXhh4OGsO5mxn+Pce27ulrz6v6
 w=
X-Google-Smtp-Source: AGHT+IFdn/Jr8is2yWdWdSyIB45VFruqPLsBAO80PnteoBH4ZA2r9oPgTrzxoh7O47sr+supryKS8Q==
X-Received: by 2002:a05:6000:21c9:b0:3cc:bb5c:e82a with SMTP id
 ffacd0b85a97d-3ccbb5cf788mr1430735f8f.3.1756311312621; 
 Wed, 27 Aug 2025 09:15:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cad431ea49sm9973703f8f.42.2025.08.27.09.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 09:15:12 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:06:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v1] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250827090627.390cf4c3@hermes.local>
In-Reply-To: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
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

On Wed, 27 Aug 2025 09:38:52 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> +use_function_versioning = true
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index 2a07b4c1f5..1ff8d14d08 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,
>  }
>  
>  /* Write an interface block for a DPDK port */
> -RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
> -int
> -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
> -			 const char *ifname, const char *ifdescr,
> -			 const char *filter)
> +RTE_DEFAULT_SYMBOL(27, int, rte_pcapng_add_interface,
> +		   (rte_pcapng_t *self, uint16_t port, uint16_t link_type,
> +		   const char *ifname, const char *ifdescr,
> +		   const char *filter))
>  {
>  	struct pcapng_interface_block *hdr;
>  	struct rte_eth_dev_info dev_info;
> @@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
>  	hdr = (struct pcapng_interface_block *)buf;
>  	*hdr = (struct pcapng_interface_block) {
>  		.block_type = PCAPNG_INTERFACE_BLOCK,
> -		.link_type = 1,		/* DLT_EN10MB - Ethernet */
> +		.link_type = link_type,
>  		.block_length = len,
>  	};
>  
> @@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
>  	return write(self->outfd, buf, len);
>  }
>  
> +RTE_VERSION_SYMBOL(26, int, rte_pcapng_add_interface,
> +		   (rte_pcapng_t *self, uint16_t port,
> +		   const char *ifname, const char *ifdescr,
> +		   const char *filter))
> +{
> +	/* Call the new version with a default link_type (Ethernet) */
> +	return rte_pcapng_add_interface(self, port, DLT_EN10MB,
> +					ifname, ifdescr, filter);
> +}
> +

No symbol versioning needed for 25.11 release since it is major release.
The release note is enough.
