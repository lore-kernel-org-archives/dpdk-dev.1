Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7D0C4451B
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Jul 2026 09:18:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 070E040290;
	Sat, 18 Jul 2026 11:18:13 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 69B894028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 11:25:42 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so25054755ad.1
 for <dev@dpdk.org>; Mon, 13 Jul 2026 02:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783934741; x=1784539541; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K14u1PvfB9yNqABgK/cNpbYp9562A+/0qNqCASnkTiw=;
 b=XhrzBAASf9jYO1oQ0ZL4h/iGfW1XwSiCm2vtlHyZvZaVYXRfKZKQum7NzvOwlHJSkA
 vRQSbLfyCQY5GunLLI/nI9fZ0UkA74mzR0Ga8334m+pH7k2RTQx/sq4ZfRQ7fBktSSOF
 dKD1z0XGM4aabo1ueP3+DlNEuSj4h4AiLGHerk5dk4GA4KfahLv6sv1XFuWSRvjt8+yO
 9AX7m0LPFaILt6xmrMfP7YkXh6fRzr/qU4kOnnBQLlXbHVPs3dbKBra8qObXmF31/ckL
 xJKcQeYzBydtog2sWGTTFfQKDNWpXTCT4pUwqez2lcAO8bkeiUjulXVhP/YLQ7WzG5Aa
 1TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783934741; x=1784539541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K14u1PvfB9yNqABgK/cNpbYp9562A+/0qNqCASnkTiw=;
 b=JeVLU6BP4/8+rnEu0zOfEy5pZIVENaDjSnP4sqrDMhmR3dnJ96CyJojRMPplH334vA
 1G771JHF5EeztTfdJvz/W56SBu4ih5+HKbNWNEussFl6pmECv4c/DmIKrnDAMTD/SFUq
 ghw20l94rMdODkW2lrPdNTe4C5czJDHMPymg0eXdh0GaXLe+WlYABVehTc1mjQHeNtN+
 IIz7KVeUMJxOqiewz8vEEfCsj/QD14Bq87tvG/rkFutGBTqGCqVcN/KJFHAiOHGC8w98
 fC+tirz+G2wmD34+eOXS0bAGYpdPlY1yUW+Wj+XmfG959+caQgCY7y6k81VWO4uWYVdm
 rgeg==
X-Gm-Message-State: AOJu0Yw7MwnFh/o4VoHGCNiH1IAmE/tkx3ui2KLeX+ARchCIlHcTLKJD
 p50bwMPIkTk6lgdD0Rx+YtfEPsJRrbFMZaseGu1bmunxBfPZpr7LlLOzEywS4afv4WM=
X-Gm-Gg: AfdE7ckjnzbbs+59nY/hWHPtTDrIRyL/wSBF5irP5dTtz2eAkLcxhghTkOWloqWXc3e
 weW4GavLlHANKJfFSbSignWPqyGU0waqeoxDaZ5VHpxV5Y+1aKXyB/lP8e4pg5+ej0bEVHCBIZk
 8Gw06umDLQLbkHQPAhL0lDbkgj+nk/S1Hljz83La2oQVIvOzP1wjbVDOEv+8Afy4+kzhPrb8o7Y
 F7D+lBbobzKzzyQyApdswhJeXSroUPZLbCdVLzltu1kozeMFXG7eigosx0AzxKIie/q0ySjIG1w
 XT+Q1qPFR0Xcyi8Krx3N//Dl3uOD0FZNFvcAcDJiSZ2G4/gzlovXUdc1RIGgcC8e0TAI6J8A4CP
 d7LvS7lq7xeRstR6CmqpL1M+NwRLBSwXn/2c5QZsSrw7CC1cJnxV8N7f+UDF6bf/LdkqulgDIEp
 XOrPGtj/pmZoIk2ZhP3VXFMtnC
X-Received: by 2002:a17:903:40ce:b0:2c9:2ee6:693e with SMTP id
 d9443c01a7336-2ce9ec11cb8mr79614915ad.18.1783934741334; 
 Mon, 13 Jul 2026 02:25:41 -0700 (PDT)
Received: from dev-template-2404.. ([192.19.252.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf77e4sm95900285ad.22.2026.07.13.02.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 02:25:40 -0700 (PDT)
From: Samar Yadav <samaryadav5@gmail.com>
To: dev@dpdk.org
Cc: chenbox@nvidia.com, maxime.coquelin@redhat.com, stable@dpdk.org,
 stephen@networkplumber.org, tiwei.bie@intel.com
Subject: Re: [PATCH v3] net/virtio-user: fix eventfd sharing in secondary
 process
Date: Mon, 13 Jul 2026 09:25:16 +0000
Message-ID: <20260713092517.1631685-1-samaryadav5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703102530.133813-1-samaryadav5@gmail.com>
References: <20260703102530.133813-1-samaryadav5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Jul 2026 11:18:11 +0200
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

Hi Maxime, Stephen,

Gentle ping on this one. v2 addressed the rte_calloc() and
rte_thread_mutex_init_shared() feedback from the initial review, and
v3 cleaned up a few style items (include ordering, named constants)
flagged by the automated review. CI is green apart from the
automated review warning, which I've checked against the actual code
and don't believe blocks anything.

Let me know if there's anything else needed on my end.

Thanks,
Samar Yadav
