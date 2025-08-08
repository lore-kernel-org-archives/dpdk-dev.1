Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866FDC87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 15:28:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51054402AB;
	Fri,  8 Aug 2025 17:28:43 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 95AAA4028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 17:28:41 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so1147318f8f.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754666921;
 x=1755271721; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7srCiLeWKaGxicQsXLnx55ZQCQn4W1QXFIZ7v50RdBk=;
 b=dOpPPe2DNB6/2YP2oNVs2dgAnuempCMsIYqZLfz9SuYhNcnO0jKzoo4VDr/zZX2IgN
 4EurJ8OtR2Iluj9eTUB0Nvf8mhqjb7R3cZdRpsQ+ZhBkm+uoqJGhumRYPYpjbCAPKMF9
 mNRz8hEn3/MGkjloSOXKNuK6L2nZUr7vePZNKnJzZMaf61Ei2b/SnI6jCmoJkCRmQWbf
 nu9UYoTomyZtN4Dh2i9eoOXk2j1vVO/V4vYtf6SwZ1IVvSamTPYZ+Bd8K4EL56KFTVSA
 UYAHZZQTyDhUxpXJDhZ33tSOOFfD1caq4kDZLflK0jeIbbh2ucN7anQ4ghSPYR97+Y8g
 +pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754666921; x=1755271721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7srCiLeWKaGxicQsXLnx55ZQCQn4W1QXFIZ7v50RdBk=;
 b=Gmbl8qfgkEZhUHCCQwXOAxB6+ZDHMFFyAloCxEKQECb5GnkF/3FRLoHUo32uv+sWEu
 cYkW9hwFuhYgHg0PQKeFJinwqS0lVwmltWiIj4vbP3cdRyX+8VkZpPGnxBVh0CC3UYLz
 blhiocYEbBywcqsxEdB+LnQPCHc197NMi8z3+KXf29KWKHxpuJfBaTrvRyF8zU5pPpB3
 OvlsPv18HEaXxXmcJKB4AXw6P/jYP9kXZKjw2CAZr6jSfEvJmEQVoUmEd/8XgE+6d5dd
 7KX9hfCT0nIoJjuAG2gu1RqqvSoNBfPb2kDcPXb9yxhfiMlW943OXKjreTmN9XdHdIdD
 2Z2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+FGHLa1KlZCGHAtFYbJDf4POgmGEbi6fLDw4eepDeFUcZt4I1o7GuN6UYfQjSedAYXXk=@dpdk.org
X-Gm-Message-State: AOJu0Yxeg0OpnjDGYarY4NFOS+xKb7FjcPRs2f4aJkdMlKX4Qax6dzdv
 f5gerM71ydnr/YX+8CuowkBUm+JBeYyuUjyhWTh6jjzRRV1b1sbfTc5b7ekAy7WcnNw=
X-Gm-Gg: ASbGncsUi4S/D8645kkBzeT3z54I5ME/e+/WwnDmDR4YtRY3UqdkUg1Pu7xeZHX7QH7
 TkxhIWk7wYDdGK7c9F2u91nTaDFeMnnLAbZY0GvnU8UjpIGG5WtslFppWcQhy0hXz6nD5BGNsme
 V1yIyNm0OsynQevGYPUZfS04akRo3M1/u6hCjo68ryqFBNEwFAlell7WCY/PH/F33x7yg5K5uD/
 98O2I8PV6SlUutadmkbnR90k8HWLcAnjkUA5K77zH7uPh/+lmgtE16vqieDofvMrBA/KY2dChaP
 N6c182AE5/xMICDc7wf+Jhujx/HL5yLRxCo9Cv+zuDL1iACW1tIKPWWjamUIu0Sj3C4mWcMKnMU
 hdcqYDlGOs08orNsfsbP2bdwXa88P7ZvE7jUX/oez5noKAKZ0q6dxscISirG3zOuYzHC9iTsmY4
 rjyWEoZhuMaQ==
X-Google-Smtp-Source: AGHT+IGb1QwUbjGTZyubgE+R0705eJImEAu10uKrGi2E39aaF+FlNfua/FeOnGkq/60RrMLRzS9agA==
X-Received: by 2002:a5d:5d0c:0:b0:3b8:b33c:b8b0 with SMTP id
 ffacd0b85a97d-3b90092c9d2mr2802486f8f.7.1754666920857; 
 Fri, 08 Aug 2025 08:28:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47ae8esm30686191f8f.61.2025.08.08.08.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 08:28:40 -0700 (PDT)
Date: Fri, 8 Aug 2025 08:28:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Vipin.Varghese@amd.com, thomas@monjalon.net, Ferruh.Yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Message-ID: <20250808082835.796b3be1@hermes.local>
In-Reply-To: <20250808054452.1350869-1-14pwcse1224@uetpeshawar.edu.pk>
References: <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808054452.1350869-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Fri,  8 Aug 2025 01:44:52 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

>                  * run into use after free.
>                  */
> +               int ret;
>                 fprintf(stderr, "\nPrimary process is no longer active, exiting...\n");
> +               ret = rte_eal_cleanup();
> +               if (ret != 0)
> +               rte_exit(EXIT_FAILURE,
> +                        "EAL cleanup failed: %s\n", strerror(-ret));
>                 exit(EXIT_FAILURE);

No, that eal_cleanup references freed data when run in secondary.
That is the problem this is trying to solve.
