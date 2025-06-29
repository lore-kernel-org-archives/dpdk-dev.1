Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A120DC7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:45:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A48074042F;
	Sun, 29 Jun 2025 18:45:22 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 6800A4025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:45:08 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7d094ef02e5so535124085a.1
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215508;
 x=1751820308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBGklIvXwUDTabd/nqQiFYYbGUN4udd01T1DohoyCMc=;
 b=Nf5dj9sSOYY+mWByJqq8E3gBnRRPnacmsr/0W5t3ty3Cf5fP0qnLA/1+OK2zsIIGe7
 rPwhm9FO2fxzPsnJO4jaSqLDheUVKAgpQfDKmHF0WblDvjEh1oUMO+LnpP4Vu8hdmyM0
 BEZY4jI++ZoWVkZSJFrQmXANdPWbfU+NiLnxDlO8h6FTN0E6dqpImHR//0W1Tlj67y3u
 37kvonDTmUTmAxAemggbNlBGbboEShpIO6xJAvC0ywAyMRBjWR7Z21mknfHSTGmudqKx
 drG/Io0vcJlXKiK4Eq/XkmgQfUuiFoxmARFxTEiynDKwkzg+kQK4JKU9FT79CgbnHLDz
 +baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215508; x=1751820308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBGklIvXwUDTabd/nqQiFYYbGUN4udd01T1DohoyCMc=;
 b=oQxnsSBs6jhrlDIWDfvE2jvwr4z7keFTuUJ6YqHX3ikakg335UrATIQ5zsqWQfhw7l
 ql7P1LYUsmAV4HwBizm34kAUykmDVB+qdPyITXynkL6OYlJlk33C2yZQSzA6KiwIAcLR
 TT6ST6aCfY73vN2HK+tXYSlMo2MPxkWgF0R03w3KARK23IoMGRoEFfa5bcxClwNL2AeV
 LitZgoSDCFbF7oVQJokRGZwVqjUFfOKjFvi7vZZ/Qz/AI8XjZP2oG3nKls9hlek50lfc
 c+s4p5hFxjJIzvN0fcNACnLXDeyWJdJyUEi4X5rCKRRo/D4rLSFWnwcaABqSZ65t8Xq/
 +Vvg==
X-Gm-Message-State: AOJu0YxrhDfE1UuLYh04joJTfJMjdo73Lc63dWMnlImJ7E5GJM2Lcqqn
 MjJ3uZmdYTUKFO77JqLdYeViXBZU2PkGaSODhb6qDyQ9VrzFTipllhPWwiMSWWZhECc=
X-Gm-Gg: ASbGnctsOExx8j3gSlUkPytKCPBEf8wcsceWszf6ieP5PBtELinS+w1VXvFz1MLe/nx
 3LUG6fKR4n9aEMqQFU1gIotuqjce7H3r4NuPnwMHWruREvyuB7efoeAXnYqy584bcBY/4NdYxYT
 ZA5YROBwwftBVi/Pu0XVWwTW/QS6paTqtq4i6x2yIxai5v4U/e9EBWC7AAHFhBfEtdGM3fRhymm
 B73+KzfUhqz2QxvaL0rODxT000xf1j12xC/q9I4YW2LeCZ5WhD/hBpwC1SSF9fjIfAC2auUF+Ub
 3JMQ263qx+kz9AeN86ww/ybuf7Pw1PwHIfSsGLD0XTGsprpPh4dGU/FqJGcbprWD38Sf6ntfXXT
 WjcHrMj9PR/I/2w5Gm7ec1uM3GfwMR/lsxyBme+Y=
X-Google-Smtp-Source: AGHT+IGdvvpPqR8npxuY90lyB3znkgPZ+RY00B9aVFWOsljL9JbX6ZUl74Dv1tdyiJZggbOKHcEFgw==
X-Received: by 2002:a05:620a:4149:b0:7c0:af6d:a52a with SMTP id
 af79cd13be357-7d4441a75a0mr1271659385a.26.1751215507760; 
 Sun, 29 Jun 2025 09:45:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316547bsm456985385a.27.2025.06.29.09.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:45:07 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:34:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v4 04/10] bus/dpaa: optimize bman acquire/release
Message-ID: <20250629093449.787e7ef6@hermes.local>
In-Reply-To: <20250611071039.2939950-5-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-5-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:33 +0530
vanshika.shukla@nxp.com wrote:

> +#ifndef MAX_U16
> +#define MAX_U16 0xffff
> +#endif
> +#ifndef BIT_SIZE
> +#define BIT_SIZE(t) (sizeof(t) * 8)
> +#endif
> +#ifndef MAX_U32
> +#define MAX_U32 \
> +	((((uint32_t)MAX_U16) << BIT_SIZE(uint16_t)) | MAX_U16)
> +#endif

Standard library has UINT32_MAX and UINT16_MAX.
Can you use that instead?
