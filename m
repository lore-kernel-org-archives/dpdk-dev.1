Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C09EC54F51
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 11:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18E5F4026D;
	Wed, 29 Jul 2026 13:07:21 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id DA2D440269
 for <dev@dpdk.org>; Wed, 29 Jul 2026 13:07:19 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so896693b3a.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785323239; x=1785928039; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DbqPneG6blxdU5XxmKq+002UBCRDwCVmAmlkg2SN66k=;
 b=rLOGWyVQyVgGi9naDSW6g3t6gnPt8ikgr0IlL4gp4tJyq9oJsF8XItw2z2aKK3lsRt
 ZUXG5FPV2aE7xnxt8qNUDJfJP9gR2yXIlq/Szla61SjabJLIAAsJb40afdNRTOkVJnJK
 910lTW+kQUbzL4/IHP0IGowZBFy4k8Gl3LRS9HzUX38zhaRtnjuvdlFhS5jL3ULoYt5R
 9hF+DU/sBrc4a0nsc+BF172shzF2QpA7cgFpRdomtcytmZMQoOxd8esqDXg2m7zFDKOQ
 c+ldzloFkljHdolv7WM2BHzMf9gWg7leFSTAwGEsjFwqoNXKuZKd64MK2Q+RnBlBWe6u
 rilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785323239; x=1785928039;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbqPneG6blxdU5XxmKq+002UBCRDwCVmAmlkg2SN66k=;
 b=XnFXYH9F7fWfQHeWPP83skdYJ0uQ9h8TSTVT6IfDWlh2jY/3mUbQKYcS6dU4tt5/RO
 CqLZEnDRTYu3hgE5T0KOY71sJtfUzjoEWSiZYbXYVG97b4/wSBPKNUoon1zl3h4ZKOJC
 NhXqQxfzbV/Vt9ECAlPRzGy4XJxpUr6OWB0ei0UI/pB4ujMxjeqFx7LFPVmEipkaFZlr
 rdR3wBirydjUbfVcuM5TlJUqSTDvWdGTj1RlICMgDHnjpqyt60PQfk513Hab1w+sugRp
 owYWi10B0GNmoUbWHBkr55GNf+MU7mLkmaoz7x/1G02FuQrOJpni4ibT52FeSdySG1uB
 9RXQ==
X-Gm-Message-State: AOJu0YyWbwoknuj2Im9WyyMKDHNNQy2Pi3nbMC85FtRmH7XHUC8BRN+Q
 yGM9VX0IGiu7jawvYLNKeDTXTAiBl59FxbM/tWrp6ytJNa2bltc6j9p78x3JhCeW
X-Gm-Gg: AR+sD12qSa+dmVZ1IphfsnDrMZbjBpHD4Vn5n4tz+jn4gWF3E1OlnfHXKbnXryin8Pd
 gpgNycP3cpHdSYUH/HLz+2INCjVUIEZSwoJVLvqnFJ/b6g8KETQe7+EMvEIhB9bM6Fc0bB3PhGb
 KFwN1u728B2GCbzEe6zQfz8GmGQW5EnCbiJDqthkyNJbkoTa+jnafTzWVDWkrQNGmd95xpTLbRB
 2Pbbk0uJvsTJ0QN2urab97a5ClTE76PZ3GhoOsM8IYA4hKPIVCKJRArlOeyxPxTOOUAHa92HjC1
 yYrQMmPz+X0RoH+oRKgJADRwYF7N1z/2OnUF4LdBM1ajv9hf5tLrbZO6jR/+lS+dGZck27f9WyK
 aDFUb36Z+UzReZHwF2zKEbDV9xa/MMpxRlXlHzf4+vcJG6Oyjoq7tLEQv+v86flH3aOslsCV330
 QskdDQ99aYavEe7Obu5NI6yiw/PHWXXvMEAefHsCKj0nOHhWLKZhhQLV2HUTS6qtlJ86Nt8R3v
X-Received: by 2002:a05:6a00:288b:b0:848:6a95:a9d3 with SMTP id
 d2e1a72fcca58-84e933e8da0mr6982262b3a.40.1785323238654; 
 Wed, 29 Jul 2026 04:07:18 -0700 (PDT)
Received: from dev-template-2404.. ([192.19.252.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e9fe2393csm1250875b3a.10.2026.07.29.04.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 04:07:17 -0700 (PDT)
From: Samar Yadav <samaryadav5@gmail.com>
To: dev@dpdk.org
Cc: chenbox@nvidia.com, maxime.coquelin@redhat.com, stephen@networkplumber.org,
 tiwei.bie@intel.com
Subject: Re: [PATCH v3] net/virtio-user: fix eventfd sharing in secondary
 process
Date: Wed, 29 Jul 2026 11:06:40 +0000
Message-ID: <20260729110657.1027950-1-samaryadav5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713092517.1631685-1-samaryadav5@gmail.com>
References: <20260713092517.1631685-1-samaryadav5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Maxime,

Following up again — it's been about a month since the original
report and a couple of weeks since my last ping, with no review
comments on v2 or v3 yet. CI has stayed green throughout (aside from
an automated review warning I've already checked against the code
and don't believe is blocking).

Happy to rebase, resend, or address anything else needed — just let
me know.

Thanks,
Samar Yadav
