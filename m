Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF428CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 17:52:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F28E240A4B;
	Wed, 15 Oct 2025 19:52:12 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6EDD040273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 19:52:11 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-78af743c232so6259518b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760550730;
 x=1761155530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i/A8RXXmlhPL/Yj1lDhAVzrcoUiAAf3jUpgIHc/cSo=;
 b=ey4BVnayQG1OtXr/kF87WUMGqgw/nHq6IM4jSWnWjfOs7PYuNUmWlejilLHHELu3Et
 cidDFs4IjPsD//y9TYP+VUCWppMsLF/wHfYcKjX21aHJEskJmQyOzhEse4QxbKOR+YFP
 GRg98MSda5ltPEEZ/v6ab+B0BSt4jjO/Z/prBqnh73p252zojq3eVsTFyYOwPUuENdJU
 u+XZb8Z5Rly7tXozryHsGh6ctkemPecSKu+cTjA1CnogSOeog2/ooC5CK2Cc2g331wf0
 nx8WFk2vyxcugG3u4jAc0Dm4qVyxq3umGx/qndAaMrBpC3NzMbnXJ+mGD2IcRZ9iuT+S
 NrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760550730; x=1761155530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7i/A8RXXmlhPL/Yj1lDhAVzrcoUiAAf3jUpgIHc/cSo=;
 b=U5bbWjbPKbsB4hB9mnDLTPvf+Y8Ka4NXEBi3nR3LCJlyBfy5AxiYyfZpEGf17b97YM
 /oK/i3ZUTzbXV6PE8YQ3vYamauqlGx6yGiYn32aaGjCI5FXqW1mwmLCg++9fM9F79cGh
 9jG0fqn5uG8+plq6UegjASxPjGVlL90+ZzeVBeaGk1/JT5fsmPhUIUUBBS4sJKOKAY56
 4xjrwyyZjd7Emcm7fNEuhHgpqBkhDJFH49zfNov+c7tQCwDtyc0obmcr4oZ5uZUQ12Iu
 o9GqsqguLQz8d1iGM2TVYqp5HeAFLGwjrCy5Sjsq+c6tW8o/VfkR/4JSgD7eTPOlG8kS
 lrWw==
X-Gm-Message-State: AOJu0YzWYLHz204TLfu2kijzvt0SVctKoVR05ywQ5FbcPubDAdnHqdED
 JqFLZA1HRbpTDJlShCb+cwsO1oXD6S2/HKD8DDocx/DPZV5Kfkz4E8LO2Ejcn7t8Uq8=
X-Gm-Gg: ASbGncsSNxK9+KyxKfU7RAjOo6pFCTfvsraXZ/AIjk2HeKc3/A+3E1GoCj0Tm2kPuys
 931pgdYb3kajUU5RH2B8oh4JaB2B65YhnZ8tyxVh3T8udpkOUMCDO9+LVekCBMxYcCZCLNU71Qf
 oDYKSasZ4Gi1MmdWhQ7fHasyVLbX1L0mSAx23K++qQ77ASmlaxYNKGT6D9aFm/s8hYU9liRrznz
 OlMyO08gEvt03AcAF7nnJmz0NxMrTnxrOxLyyTiU9aDHowgG1tO/BioZ1QrtxghyZKxJlXISoGr
 Asu27JSWb3kTkPm/hLGNwaMS5bQURJ6BW0UCNTpg4M6YQkNJDblGhF4d4RODojR9U5ZFVNDssih
 QVcUV/kevrk64ya/fgY885YXWkgFtBDRUWazI0NxGWYsPMe5GruTyIwWCYqc2dRv0So1dGdnoQm
 oKWxwZbqC2QbT3QNjr5Q==
X-Google-Smtp-Source: AGHT+IGrd47dbr00f/Ts/DQh085/48kCICEFlaae+9fd7hffHvtT18gjjawb6oVFKiCIJgJQkXDEhA==
X-Received: by 2002:a05:6a20:6a08:b0:334:99f9:ff45 with SMTP id
 adf61e73a8af0-33499fa0f51mr113365637.57.1760550730383; 
 Wed, 15 Oct 2025 10:52:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b060b66sm19684282b3a.8.2025.10.15.10.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 10:52:10 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:52:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, mb@smartsharesystems.com, Aman Singh
 <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 5/7] app/testpmd: use space separator in dump commands
Message-ID: <20251015105207.288a5b94@hermes.local>
In-Reply-To: <20251014124046.1032293-6-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014124046.1032293-1-thomas@monjalon.net>
 <20251014124046.1032293-6-thomas@monjalon.net>
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

On Tue, 14 Oct 2025 14:33:38 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> @@ -9099,7 +9123,6 @@ dump_struct_sizes(void)
>  #undef DUMP_SIZE
>  }
>  
> -
>  /* Dump the socket memory statistics on console */
>  static void
>  dump_socket_mem(FILE *f)
> @@ -9114,7 +9137,6 @@ dump_socket_mem(FILE *f)
>  	static size_t last_allocs;
>  	static size_t last_total;
>  
> -
>  	for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
>  		if (rte_malloc_get_socket_stats(i, &socket_stats) ||
>  		    !socket_stats.heap_totalsz_bytes)

Unrelated whitespace changes in patches are discouraged.
