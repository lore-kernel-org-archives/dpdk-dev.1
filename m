Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F99BC36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:28:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D4A84029A;
	Thu,  3 Apr 2025 01:28:46 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 51A9B4014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:28:45 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so320825b3a.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636524;
 x=1744241324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Syf8ZVFFMu5fCMive0YltdLo0auRw9CYFIeFEezkAzY=;
 b=nr28PXtjexJY30mMRyexpzxjrkGo2xjJlnQAjMT9qFRs36jarTOg7I2/p6puRXNdmp
 v2aezTzIlw9IJaoCAolboWWjIp1pTqckO1iAK51rv0UAgvlS+6BU10ltiRBu1Svk50+Z
 f7JevNu7+YJtbRNWvGlcXm5SX7jY6kS0rAr/pZMRWDBn2XJUad1A/129SakStTTSwh4E
 DzTY0vf6wsRePl8a/Px/RBUwF9Ml8N6/SPxS9XO2RXSD+gJGPyF70EOCy9OGcpvhtz0h
 8ZGN5Sy9syFFc2cUgYShxKmNQaN834iB3SKKZlpL2pJPepmRLrJMEUSXv9fRy8tfgGrL
 zAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636524; x=1744241324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Syf8ZVFFMu5fCMive0YltdLo0auRw9CYFIeFEezkAzY=;
 b=PLah5Zk/dZ2yyghRsxj0hBqGPnhlnyaE/o2dY/tzIsFKxhOkD3nkcotVQbrnUjrjY0
 60uWyKjMJV3v0Sm6MMUg5j9dNqIWWAV3ThRiH7bgFP7L0YHZPYvDoQIAKyhb71XFo3Rt
 Uj6bkDphC0beD8hwK1WQ7pkn2JZWPrTvv0WM1gJzeGjsyk2doomfb66fMZtRqOqEl+eW
 7eiThxrvkoMHb1pXxiSpTXa2z6GQg1HBBF6X7s0Irv4QnggwLkmGA3eopyfNOqkVaPMR
 +uW0QJfh4ieuFwYRm7ODuxPQUXJbgs61HjpSYmX/wUuKRjpiGF7EK5DB8Wr25bvVhLIE
 9tXQ==
X-Gm-Message-State: AOJu0YwOPQE5wimymLaqb6w/Da8tWCfTkGqlDho+Jx+mu5JuX+ys3gVl
 8/x2chE2xGWD2GCSvTu86Q4Ht9Wa6xYfExqawAbzKcOyIrU6cjLhtukeFrgoUg1z5PON6CGC/w5
 t
X-Gm-Gg: ASbGncsAz0ZHK9WZNR1bTEX5sN9YQEo8/tRaNwHNx1nM0wFiYB3OWCiCEOulGf8LPMj
 /DChxgc0o+o5GEYUQJvFXrB1LAkRzk1ELP0HeqagYPNJmTb3vGt3PhUQEDUcYsTuFGc2N5vsBxy
 zBSteabEzEJYkwvE/OqvNkMLpbEykR/1lM5sQaYwYZVNxcfTNw8tZ2CEnBJPNMu0pJLruQHCs06
 N/9FOfdtb3DyyU2vPSXuq6JKjfmSG2Cg8aQzl5SDzKTft/R+ivUhdAe9BVCLXTY7zZyVrnF+lkk
 oxHZeHYVGolU/OnE6bVcvRuMkt29kfCV/wem9rhDC7OnHV1QIjpfU4SVQdKVV4FRzoyU7XMQCNJ
 pwAQiKVK5oE+yppvQDNlu
X-Google-Smtp-Source: AGHT+IExRhGBCAVJh0W7MxomiP7E7ZiiWMqdlLAtNS3ZLtd2FcdfNkeJw1hKKkzlYhwGnlLZExQlFg==
X-Received: by 2002:a05:6a21:38f:b0:1f5:a577:dd10 with SMTP id
 adf61e73a8af0-200e4cf8199mr7018002637.36.1743636524446; 
 Wed, 02 Apr 2025 16:28:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97f36b0sm96659b3a.68.2025.04.02.16.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:28:44 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:28:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 1/4] usertools/dpdk-devbind: add bind/unbind for
 platform device
Message-ID: <20250402162841.26ed3985@hermes.local>
In-Reply-To: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:58:32 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> This patch mainly adds functions for bind and unbind platform devices,
> such as bind_platform_one and unbind_platform_one.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>
> ---

Please use cover letter option when sending multi-part patches.
