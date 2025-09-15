Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2166ECAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 15:43:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC8D54060F;
	Mon, 15 Sep 2025 17:43:50 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id C5704402E3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 17:43:49 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8116af074e2so418470585a.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757951029;
 x=1758555829; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlKPhLKSmOR25vcXniZSM5YK0dKkNzmF22NNwJchpQQ=;
 b=aIp7BdeALruCQlOGHv/5+MHMS/wNQY1sqQ1P1dtb/ZBrK/QnCa7V4GiBLFark+7igx
 4x9qk6eNAvxuCsUfU5U2zFe89CY1POUSc7gInEnqnmb4gWWmFXIQ5pIKrK4QRCC5BJM6
 wQxhumsmMVHABrUZegVkhZ+q45KL5ahh9NMk+L8uDb5xNAPR3YsKLA0um1Mc3uPZdA1y
 At2jyM5Gv/Q1L9vrdmQDbMw5sK8j0SLfafyp7X8QRe9G+ET2inLpJ8n6D6NwZZF4Whmq
 Ot6DV1GDsnK+uhKjRAgHTQAoL0LC3k9gZYyFTlOaekkO/bkTM/TKIYKtMpiH1U1H11Y2
 I0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757951029; x=1758555829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlKPhLKSmOR25vcXniZSM5YK0dKkNzmF22NNwJchpQQ=;
 b=XV4KJKaDy1yIBeAL0GOJP4aqJ0tnQLj2nAnlzl3iEfG9O9LYoxEps3VPQM1BOwISPk
 9+dFXudCJTmXvLuzxwoUx7Se2T9ChtOxrH2yhHiao/0YK+YMmuJ+j73Fkm5V13Jxw8PT
 ftBaDjykd4wPVcxroOkBdksPZbkBj/Y6pzv8Ke0rfVgG1HoulVAluBhesnf9+Xw19uDX
 MZ+jrluRao7/F0wlCcbW9X6cnapBMwozvyQcuF2fsT0iGPK2Yy1JtVBFl6OmLkU20axj
 2SwwkvEYDW2KAZeiveHQwXbIAKUmcOkhyQubVhU5r809ouqVT7KWxY3WFVs+Occ70+ro
 Gw6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2QtrBW+DD9ylTqTqwHpXUCCeKpE/3zaV+r+JHVtvF5VODQdwUOg3bLci8tQG4HKGrZF8=@dpdk.org
X-Gm-Message-State: AOJu0YyXf3Xnf1S3KXKeH5IKhWsfKlsSS22Bt3v1VMBcn2UDgSzT+90F
 HdbmqFvute0JYB3afwen7ACsZVVUxoZ4+DZE4N9RzN+dcVGeAHb8WyozZGPMeh5iYFA=
X-Gm-Gg: ASbGncuj2bh0ioSeYz6734qZMIWIgo4zCqVOpu4DT8xBKBQedSXma4aclZX89/rDAjX
 7cqZtWRqV5OMzUdXnqDWpdbJ2edFmlNcuuN7iooPZPKIkhhCFI0ppzbugNTXlS2XuPLenHL1d2n
 HfBKFw4Hzg0Pp2ikGhtfYKseslXtRyQMjc/TXb+4rsUn1Wq//u3qfuOPA+fmwfmF2OmYjG9PyIk
 7Oy8l86+lqYuoEy/mj+KV65Mr6DuiLcvRDs+hzPafxCRVIagZ35XtpVFGGslsK9b4KTKwBQ97s2
 NZDTZk9OnO+k27sTJhWnpzOtFfKMJJnh+cJnSIGWhJ5AjvfUWDKagjgE7wB5xY5Li23azl6Rctz
 hXweEr2GIC8sK9x8P3ifot2UthKyw50xZ7C5j/jnlwkqZDoqLXfZ9OW+GkLqAEI1w/CWFYW5K+z
 kaYNtpDLQloA==
X-Google-Smtp-Source: AGHT+IGcbhmrzrjZQ92R7rl0Sf8qzntGt/QDgc3AzaCZzfaAR1nqQQIy7mi7tQjjiylY2ZYJCj/rww==
X-Received: by 2002:a05:620a:40c8:b0:7fe:8292:187e with SMTP id
 af79cd13be357-82403498667mr1615023685a.60.1757951028760; 
 Mon, 15 Sep 2025 08:43:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639b997c4sm68467391cf.2.2025.09.15.08.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:43:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:43:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Lijun Ou <oulijun@huawei.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Xiaoyun Li <xiaoyun.li@intel.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v3] app/testpmd: stop secondary process fwd_lcores
 during primary teardown
Message-ID: <20250915084344.5c95a47e@hermes.local>
In-Reply-To: <20250915112513.496136-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250915112513.496136-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Mon, 15 Sep 2025 04:25:13 -0700
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> +#ifndef RTE_EXEC_ENV_WINDOWS
> +		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> +			printf("Stopping secondary process...\n");
> +			struct eal_dev_mp_req req;
> +			memset(&req, 0, sizeof(req));
> +			req.t = EAL_DEV_REQ_TYPE_STOP;
> +			eal_dev_hotplug_request_to_secondary(&req);
> +		}
> +#endif
>  		}

This could be improved:
	1. The structure can just be iniatialised as:
		struct eal_dev_mp_req req = { .t = EAL_DEV_REQ_TYPE_STOP };
	2. Check the result of sending request to secondary

	3. This is really a different MP request path, please don't
	   overload hotplug for this. Register a new type with rte_mp_action_register()

        4. If done right, you should be able to drop the #ifdef around WINDOWS.
           For now, there will be no secondary on Windows so the request to send
           will just succeed as a nop.


The other issue is that stopping the secondary would be faster if you
used existing f_stop flag to break out of the forwarding loop.
