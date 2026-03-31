Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90AF10F9308
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:53:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA05540275;
	Wed,  1 Apr 2026 00:53:18 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 0E6F14026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:53:17 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c66eafc1easo4630752eec.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774997596;
 x=1775602396; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjBYEByWzdJsrSuG7mrCyUzojXY4O8IbdaLIJLPwP9I=;
 b=yU5Tq/zLPu1mjHUy3JR+eTeKQZurXSaq5VVf0s4qL4zEk+3uCSI1mbZltZvVJ004Am
 4fz9TEmQ+wrcBmfZxiV3EjVuJa+Go2+bKldPNDrCSw33EeiCTeq1lmtPd9phwsXbKdMH
 6SkGd4iHPChjOsvxeSjmYoIrjgIMfwamh0Tv9DA4/Xcy4ex2cqo2/MvYBZssjoDiWW7q
 yv8lHgPKoXYLQyyeApmn1Hdl7gXEkPEANkZYodlPS8htqfKg9zo0+rWbF2NOURKdXUhp
 XdEIdfDNTzK5dG6mqZNP5TVIUGSAs4CaZGwX/JaRlISEDZEtrDWc7QvnyT3cIA8nxpiX
 ENAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774997596; x=1775602396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjBYEByWzdJsrSuG7mrCyUzojXY4O8IbdaLIJLPwP9I=;
 b=Ebzt4G511p5eTyc1ySW7SAsrmziImlfdydBcxtmMaP6eaxtrsKwH/UCrDBXp7mLpe5
 AIFyiV5Ow5fZXix72wPEQZyxon4BUZsJsCDEl4PPy+DdYK4+pCozHZMTlz0mJCM5E1F3
 GtYulFZs05nEBS9Tz2/Du65eQB2FYif5NykJrPK+E9tILT97fd8zwSvIWkZBeKGXTGIm
 D4cz/BS2qvMpFhl8oGQGSArZSDHCSja5518nPWtWJgBxeoUKwvLzyWGvELqb0MrjEs4+
 oeIaqdVMifxcWVmAGaA6N8IqcQHz8YDwPWSDzo2hZbTqwhlKkYdxxQC1A6YiOecWIKmu
 lI6A==
X-Gm-Message-State: AOJu0YxlcZOAvrOJma8JFDSfcndEE3A+7hxC9N313nOqN/DXDQlkywL+
 AeXVrUTJJ9/IDd99QY2fDi4zmJTriJ3NH7WWkJ3WcHZyFlJ/JLOMUtcHECEAxMS1QKk=
X-Gm-Gg: ATEYQzyBgMciRfYAyRMPDrYTFK+JqjBdM9x8LJIIFiWBnzmYb13y1w/3H+CMbvxFCIQ
 fTbZDhYljY0wIAoi0NG9GtuQmnC9+c2FpIOsiWMccs+qxambhIcquNGSrf3+Ho1lqpHsE03ZDuD
 KUd2v5iMd+4RsLyv6EtvhaP4UhKXlbjQEfeKQfPoXjEajG09KJpMgG43n5E74IbsSLq543XL8eX
 nlq6yi846+BpuTKA7m0TzDE15dRklrwWjBJ87d6JT3d0H37dI24z2wUSSDM0fE3XERbRT1IUbQM
 NAG2s7u2PThlKi0E8lA/TK4xeySjoP4/JTEwWisonXdrIj7i4WGup4tMcxqP/3TUqkey8m61Z2T
 2j1EyLmin0e6xCzW1yQiDr0miaMie4q2hyl+udd+vBJPLk2ElB3OVGfwCkjBz0C7jAFAIV2n2jn
 +OXhbXd79ZRmf+w4c21GaTjboSWoG0WTO8+ww=
X-Received: by 2002:a05:7300:2213:b0:2c0:da6f:55e0 with SMTP id
 5a478bee46e88-2c9329a0db9mr784524eec.27.1774997595960; 
 Tue, 31 Mar 2026 15:53:15 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c68b249fsm11004489eec.19.2026.03.31.15.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:53:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:53:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 3/9] doc: reword design section in contributors
 guidelines
Message-ID: <20260331155313.5611943e@phoenix.local>
In-Reply-To: <20240621023254.4258-3-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-3-nandinipersad361@gmail.com>
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

On Thu, 20 Jun 2024 19:32:48 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> Minor editing was made for grammar and syntax of design section.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

Integrated into https://patchwork.dpdk.org/project/dpdk/patch/20260116201738.74578-2-stephen@networkplumber.org/
