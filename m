Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC183C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 02:51:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 704C24065A;
	Wed,  4 Jun 2025 04:51:44 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id B1039402DC
 for <dev@dpdk.org>; Wed,  4 Jun 2025 04:51:42 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6fad8e00a22so45006076d6.3
 for <dev@dpdk.org>; Tue, 03 Jun 2025 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749005502;
 x=1749610302; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+NBqHnJpXDRdc5vArMSD8CpKmVKK8DIlmVuRpY01p4=;
 b=G+T8gjqa0yBUhsc453EsvbHLJ5KViHQeAiwnoS/hZdgjU6K8bumIkgYdZjljKugs7/
 u4ijHWdB99F85lEjXhoxcANguXIzTdr5eSkupaOD6XQJFWsWrWxLjzRwqfZF4EavvyTY
 HIawGTh+uXFZpnFi02NVwocSQPVSCE/uO54Pm20CnxC79Yo6g/jCPYGkKe2sZ8PDI7rn
 DtEIbhZz78KcML5RLMqI0OjwL/G300/XzbgVPx0mjETHln+sLZnWv4UzD28Wv59/Wwu4
 6gHJOaSba3v2QvCytLimhecMPVnOET1bnIfaibd/+e5BbMlRbujK7ff75gwShqIZI5l1
 EL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005502; x=1749610302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+NBqHnJpXDRdc5vArMSD8CpKmVKK8DIlmVuRpY01p4=;
 b=BbzbyQ/aLuMsdzz/mxlxedIC3OOmAzHzykVLmOfobDvWuUF3GJlLHe3BgJ+Y+W3X/Y
 mfWaNn1lVUSHgI2Eri+0JJQVo4KWNOwq7vt2cqYe3Iasnod868a+Uxef5pCOz27TAVVA
 d1K15NbTclqgL+YO5rQcajI9VF5iUYgLOXKOTsNyA1Zyk2Psv/fyzlhplbIDhjGjRPTN
 p/OCUsWpvdlQ48EAOFJWqZCHvpYV606BP+pGQA6jO7o/AiNNhs7OV6TZvI662UBOJitc
 Bkdv1akY7Se77u4cvvhgdxreG3ygVSUG7d1cJJG1MeZJnE+aEuh2EAn4Xms9IzWfYjvG
 qEcQ==
X-Gm-Message-State: AOJu0YwHHSKAgQMLrQKRYZ+uf4ompOdlpRAZPxn0G2YozCd1Ab1ffduH
 ieXmQdSz4VssNO5EcFYrM9B/k6BUTo+O6pboUBzNiFWOBeZpMmZkRW+8PdZ+eI/Ist4=
X-Gm-Gg: ASbGncthTkCxRtTuSy9uxiUtAuyNM0wQ6aV2+K2KGnUbd6zrFqG5jvshfH0PMonbHbC
 RzMZPbc/7r6lkagGuu3YWntOQBU8AmZY9cskZxDS+y23ZtW5IOC48UNEMyYxMZA6MjMxVKlh5aP
 gdgV4XbeBe5+KL4q9v1wIqmnp88HeIHuoVmvLLBqJxdNq828vmsg1ImZ/Wsa6zw/NneXAKRFzDm
 DUPPOudQfBSI33lbF3jkoZ4Tiu8Hwkh5l26KWEXldbe4uIKP94GaDy8KXqcca+os+nxQUmR07Hk
 KzMa3GcnrmD3BP7ckDRbZ0n6PDLzGsXK3m6bqB1fpnIXcK+rHeinWz65ZZXML3k20jYS4WEfcir
 esnh63w9a13jAoJBhVqvEJdT/Vxxf
X-Google-Smtp-Source: AGHT+IEL1BpCPt9d7ttxZ4JaRwB5STBvVI3RCIjQDgjkcuQ91zYK0G3ZScmWOX9rlpuatqG+R3R7aA==
X-Received: by 2002:a05:6214:124b:b0:6e8:9086:261 with SMTP id
 6a1803df08f44-6faf6e988efmr16871636d6.3.1749005501872; 
 Tue, 03 Jun 2025 19:51:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d33901sm92054256d6.18.2025.06.03.19.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:51:41 -0700 (PDT)
Date: Tue, 3 Jun 2025 19:51:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [v2 10/10] bus/dpaa: optimize qman enqueue check
Message-ID: <20250603195138.310a98a5@hermes.local>
In-Reply-To: <20250602131526.3233959-11-vanshika.shukla@nxp.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
 <20250602131526.3233959-1-vanshika.shukla@nxp.com>
 <20250602131526.3233959-11-vanshika.shukla@nxp.com>
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

On Mon,  2 Jun 2025 18:45:26 +0530
vanshika.shukla@nxp.com wrote:

> From: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> This patch improves data access during qman enequeue ring check.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>

Still has compile failures, fix and resubmit
