Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC1CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 19:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 338F34021F;
	Thu,  6 Nov 2025 20:37:23 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1AE9F4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 20:37:21 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2953e415b27so13192165ad.2
 for <dev@dpdk.org>; Thu, 06 Nov 2025 11:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762457840;
 x=1763062640; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hwBAQceBGXMknbH69+c5HpZ8fEg8aGJ/0HE5ldnGXg=;
 b=IVcdW1NmaXvlB9bbDHneTi0b5JBl4uDVqGRgrvcYxrdGQXjj2cO/nEcu7K23UTxKHs
 JGddGx8uXnF7V2tfEgILW2mEOhym7JSIoKyAV2F1MEduiPNi98vCMvHUJrVRSQxxMZvA
 cO4lzkfhzZvNshoxzSy+vcPPmGeZBRGWvH3ucKxqFy7dhAKEYL9mABpId2eSuojfA620
 R3c7q6A4qI+7CIFebecZWjwUrgRLNOxBy1I6bDfa37zH6IOwZ/u1hl5ySVlICMVh2FA7
 5mN6UMWN21tuBv0PPbox/lIW3+dGrPMKQdP0o0WCGrUXsNVwTA83Ay/YTXI9wGPAiJtM
 SlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762457840; x=1763062640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5hwBAQceBGXMknbH69+c5HpZ8fEg8aGJ/0HE5ldnGXg=;
 b=gsyxqfIEU8mrh/HxDXT3b6Dwj2jbzydaMKUz21mu1w1sFzTEe/4Gt5d0uUdQPT5R9N
 LeE6YHdlbF2NpaRlmE+fSzq1QwF/jAWOSXygYmvNMEbP2VWYqK8MK6125T0pGuaKrpbZ
 fYUfCVEWl3CVb+wVySR9ivvCrfiEJ4C7Uta0KVXZM8L2kJW09gFC9EZ7ClO6FL+nqkiE
 OuN0uRYbTIgwd6+AVdKtczU3Yms6qruEzsUPgKkRNFBUmOP5TWhDu8W5eofso7cbYFqd
 2IPjNwJKRWjCv80sbSlnsIJZ8ZN/kCJWDXBgBmpK2x0mYnBQMg471TVQ/jT93AQ0g7I2
 ssWw==
X-Gm-Message-State: AOJu0YwgO7T4YkMqAX+IchSnDlDw3xzS7XyLdysPIhymoMOqc5thrmvA
 sED1RYCdeHoHMbInjT85plZmupYnbWZBNx+8VLg9QoPgw3TGvrcf2qasjRVNO/SEREU=
X-Gm-Gg: ASbGncvecFTQgMgeR1/AXi+PVk2EYjtmO3PMBJB3GWYZjn1RpkJORPa9seSr9hqHs4T
 Zh6UC43hxVK4u4ly1wchMAlY2ABCJgfi3RasQ/LE4QWl6nXZIvRJsh8X2hv321Qq/WlIyIrmFu1
 gY9f8dYxDM/dAjyLRzkNw3ZTMPY3npmCrka2xoYOPntb9Mv6MBbJL+q0tK+SK9yxW0ALFWtyNc0
 2j3cZ9QI/iIyS/Njvb7v3UPb9MPcIebgdbOJPgGOGd4dtiaDj5nRo23VzhWp96bJqhL4NTqVouS
 BPigAHsvzMRaGhhbx0HrOGRmfvIXwECBem6YhW2wXaOq/myq1MsO7JHOAbRaSW/Le8ucIbsLzrr
 zd2SThgvIOsjRb/ENnlCWm74DUbd796/WujoIDizrWiItXs98D85rokTqSS9VRCUKPcv7ogfw9c
 htkneCEP02aHmtxzrY/m9d55n8FmQ8NthWgQ==
X-Google-Smtp-Source: AGHT+IGsq4gb0lRBYcrNaVFKN5BXJxBBc1RELvGss/CRd9ngEdzBxpVs1DeVAf8M5xiR0vPk0/juzg==
X-Received: by 2002:a17:902:e784:b0:295:557e:7465 with SMTP id
 d9443c01a7336-297c038cc94mr8947385ad.11.1762457839413; 
 Thu, 06 Nov 2025 11:37:19 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650c5f94fsm36582145ad.40.2025.11.06.11.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 11:37:19 -0800 (PST)
Date: Thu, 6 Nov 2025 11:37:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [RFC PATCH 07/19] table: fix issues with variable shadowing
Message-ID: <20251106113716.232408f4@phoenix>
In-Reply-To: <20251106140948.2894678-8-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251106140948.2894678-8-bruce.richardson@intel.com>
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

On Thu,  6 Nov 2025 14:09:36 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> diff --git a/lib/table/rte_lru.h b/lib/table/rte_lru.h
> index 28aab12923..1436425e16 100644
> --- a/lib/table/rte_lru.h
> +++ b/lib/table/rte_lru.h
> @@ -41,33 +41,33 @@ while (0)
> 
>  #define lru_update(bucket, mru_val)					\
>  do {									\
> -	uint64_t x, pos, x0, x1, x2, mask;				\

Why is this a macro? Prefer inline functions where there is checking on types etc.
