Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E3C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 16:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D09C40276;
	Thu, 26 Jun 2025 18:02:33 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 78EB940156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 18:02:32 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6fadb9a0325so11525506d6.2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750953752;
 x=1751558552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrT8Vln8HMJ+7SGnCeeftsJSSY3C0BBlGeOBWcoJQx0=;
 b=A4EBCK1DVqU8/VqFfUr2dKkkc7YvlHqjmEfdtgjBn3NU9Meb0VVTblweE6uHrSYNGv
 eP4M/L6XuIoxsvQXGDeqVh+frMj7/1MmJBBQRE614SCjw+Nn4CqNAmvkST1rxV61kxUy
 LyEnsbfR1heQQqoLQXlHgmOgeogPSfcqEvA3W8fjuqhv6OetbLGCSuFCxvXRD0q+cdmM
 cNcDXg/skeb24J2FgvSCCnMjuqooTQUVCxofTbJbiVdjMuFG8mdnwadAQWnB3xyYl71a
 1hRfCxOasaUFSrRoy/M+IcaPvaI2J4kgMo4XRmzkALHhnLHXulLAjfdDo9ADRDM3LIWV
 ofoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750953752; x=1751558552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrT8Vln8HMJ+7SGnCeeftsJSSY3C0BBlGeOBWcoJQx0=;
 b=BSctKfk4Icamo06Uw3HDh+RF/bMCqVWKHtj6dWPNSph0Gs7F76pzAkG7lG3EluvZ+q
 O29vUOX97PpyHQz+QjupvyFZPC+0VhjypRMlK5C0RRPQEJhCtDHT5T2XDe+kWgRcilfI
 kWUMArqVzMDMvzaC3F+cDaVwJcJ6YSqW7SvqB77yEQJbubADRQ3g8uqz2lYJGphE8smd
 6bbI45SbPvFk6qYgGh+TNiUjhwn6nsphDoLCja9MXO5ot3DV7wArN7t4dtVjwXpKUVre
 y9RCKwk6WM6hP3slnNGdlwkJUODFgA88lewCoFYQkNy7/WaAHnMbV+qhAJtkkfzwiQ0r
 4J6Q==
X-Gm-Message-State: AOJu0YylRun7eP7tCYy/Rq60yC34sVBexIvLor83MDcBNMODqh2gHl61
 NDy7q5a9xyjPQPL+72C8anYuUNenTL89t8teaigg5NLJR3uyKqu2qE3eD4NGBHcQHPQ=
X-Gm-Gg: ASbGncsgqceMYxAvc7GLR3N1paSK5ekDpVymOJnMFLoNutiiWFFI+1O+4+aUHnS3Y4S
 60QhQXmPT8seE4eQauCSBwlIHiYBI4xQBEX009om65xBMAL6ID9y0YedcDxlEQUuucYPLjdcjaf
 3nh19gZMVVL5id18zoIra4i4wIxbLbjbMPBpgKR5PDz2GXiLgtKg1BzqK+ROkpr9s6lyFgFY+kd
 GaOcj9B69zHocCp06DHPOXTmWtr1uF9KKaln5hF8gvsaSu8iY8ER2iIwEzpPY+KKg4N8t31Y10W
 HPU7zT5jq0yg/by9lR+zDQoWx9A/mbPtGzOy0aYNRwImHUE289PCtOV478LZ+pzG30M9OvRL1xx
 zttl9zGw+PbDIkg1CESj/EJudhcjpOln9hMYZzgnOk5BC/YmAlg==
X-Google-Smtp-Source: AGHT+IG8zSiSv3x4QHVHFGllyn8fkSLkxmMW9unWZMqRvzuLZhvUC+pyObD0qeVt1YonvxtLWfyJjA==
X-Received: by 2002:ad4:5b85:0:b0:6fa:c512:c401 with SMTP id
 6a1803df08f44-70012fcf43bmr521666d6.37.1750953751413; 
 Thu, 26 Jun 2025 09:02:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730b726sm8916656d6.114.2025.06.26.09.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:02:31 -0700 (PDT)
Date: Thu, 26 Jun 2025 08:58:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Feifei Wang
 <wangfeifei40@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: Re: [V2 01/18] add some basic files about hinic3 driver
Message-ID: <20250626085811.0248ae35@hermes.local>
In-Reply-To: <20250625022827.3091-2-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250625022827.3091-1-wff_light@vip.163.com>
 <20250625022827.3091-2-wff_light@vip.163.com>
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

On Wed, 25 Jun 2025 10:27:57 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Yi Chen <chenyi221@huawei.com>
> 
> This patch adds some basic files to describe the hinic3 driver.
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
> Signed-off-by: Yi Chen <chenyi221@huawei.com>
> Reviewed-by: Xin Wang <wangxin679@h-partners.com>

The Subject here should include net/hinic3 

$ ./devtools/check-git-log.sh 
Wrong headline format:
	add some basic files about hinic3 driver

Invalid patch(es) found - checked 18 patches

