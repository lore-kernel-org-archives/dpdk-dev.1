Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCD3C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 16:45:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11F34402EB;
	Sun, 29 Jun 2025 18:45:21 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4D7594025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 18:45:05 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d44e4d248dso138513785a.2
 for <dev@dpdk.org>; Sun, 29 Jun 2025 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751215504;
 x=1751820304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnPBTXQo8OUlLtzfp2GT5x5uJSLKJOOwgaD+zZZtJ3o=;
 b=aaTo4xUCp25YAqY6EXt875gS+ZNP070Gg4cTxh8mtYuC1Q3pjmYF/bfBlbqTQIHzy9
 OYtNxLqYdytH+z8SpiBvCvcPBTBlIBfR5P07Q8GgUUdw5Stc/cd3tgCWrZ/0zgAnKtRe
 waSy7aYJZHupJ6m0B1g/EWL60+O5piR9fMf9GJVG+DwTJmJHOMo72CNWnvjnDawxIe50
 iM30gemg3AHomEGgPiDiFrgYmqMLR4PNbaLuoYtl14Dj1tY8B+cevvUcMcRiqF3XgQIb
 Mui/2Yc6mn8vcFokF0uJjEof2wGqzUWafh3ri5PzW2V+AADdupknPUqRLcAfrlToK9kl
 jJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751215504; x=1751820304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnPBTXQo8OUlLtzfp2GT5x5uJSLKJOOwgaD+zZZtJ3o=;
 b=LdqviW68DO1r5BYNkS++YN0zoLXgPVPQoHv8ZEA5M8vKZ5OMUnOXuMkY/cUmRhJVG/
 jwkBaiIHcWJIJlXYLoz2HLuugOOWd//GbIogTAgbNca7d3NtmH6giCAnTEysVbljVFlm
 IYCi6mdWecjLg+NDqTkchP+9uS7148q3Iv7byQAQA/p9pIvhYLgDBsLHoGVQm7v3xfTR
 Y4WxFTvB0Q/J/XqaWgBTsG54j9yLeMu0iqxTSQ+cHPZuh88/lWkEh1VtYdo14k+DNIVd
 yHz7cmP1TNBxWSIl6jRTFEcqnY+J/HQ1uuuSzgu7Cskdk89pCb2mqENd9GP6jPqEdfnJ
 3Yeg==
X-Gm-Message-State: AOJu0YyyhWIwKdQvXirxkyPQ50jwbWyy+3pFFopWDxTgZYlNAQNMwYAo
 Q1/JqJI8WVnNOVBhyfN3ytn/GWg0pdK3wx4NFc2+EKe8617u5JDu9MP8RBMkX/dg4ew=
X-Gm-Gg: ASbGncvUnXtsPrHW7p9XmPl1mFUj6jKYHCdUrbKxyho62ySzXm4SwYH2Ni04KPfy2HF
 qOYC631hc4ycPT0N9tNfDsAoixM3f2OIWZjEhzjbA30epczejPykV03rMWSaHmefFbCJflg4J+a
 A2QyuanQYso9ybT3oFBMPP1qEW7YciDuCKmVFQ7PhMybzOWd8EayD3YQZ75XSiLghO+yyNbsDVl
 /mbDrc+SGK66mBtaNmbGpS77JaN4sTPfj1kHydP9KZN1KMtYmp4YtfgEKWclXhehYXgzW+6ysKE
 4P9gZIL63uB7NH/E/UvXH8QYtnZ9oIrHx+rWziU+eqKIsuOwBL4SOiOO97cEVgQ6c1pdiwwuWxj
 OJl8DPmCoMJh85+l+XROJAJ1jH0lLzHGO51zH22w=
X-Google-Smtp-Source: AGHT+IFloGQk/6Gaf0F27u8c0AXekwND7/Jy8t98bYHLj699Ybr+7QYU3kEYc4QjpQS2u1BFOqgeGQ==
X-Received: by 2002:a05:620a:3728:b0:7d0:9ffd:422f with SMTP id
 af79cd13be357-7d44398fde2mr2004578785a.54.1751215504709; 
 Sun, 29 Jun 2025 09:45:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316547bsm456985385a.27.2025.06.29.09.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 09:45:04 -0700 (PDT)
Date: Sun, 29 Jun 2025 09:30:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v4 01/10] bus/dpaa: avoid using same structure and variable name
Message-ID: <20250629093037.1cd5f92e@hermes.local>
In-Reply-To: <20250611071039.2939950-2-vanshika.shukla@nxp.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-2-vanshika.shukla@nxp.com>
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

On Wed, 11 Jun 2025 12:40:30 +0530
vanshika.shukla@nxp.com wrote:

> From: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> rte_dpaa_bus was being used as structure and variable name both.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---

NAK
It is allowed to use same name for structure and variable name.
That was PCI does, why does dpaa bus have to be different than pci?

