Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC8DC87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:00:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C1304025A;
	Fri, 25 Jul 2025 15:00:43 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3A60740144
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:00:42 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-75001b1bd76so1385906b3a.2
 for <dev@dpdk.org>; Fri, 25 Jul 2025 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753448441;
 x=1754053241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4QhPgzDaQW1YoqrScs5f/iteLWSra3lQ7KXrB8CQh0=;
 b=ffkrydw7aaqXumLBxa/p44zIfPnQfEtE4ww2PvTyFGmuiEbjPuXI01HfSs2QwqhLjt
 LIpiB0s+3slI0tgt4QDDTSNm/I3RtDChSIx9qsUIURkvTDImBtiDb01eiaARZWUYNc2l
 SYRqtIBQcLWte5OCVpL39FHFTr7eD6a/LtxAaABDIishKkLIe8fHTlSz5yEdVR26pTc+
 iJVxRLW8pjGrtPX+96PRxqKBBvYNCkVdAKCqoGgQsUdXAooVWVkY4U8TPW4X959rkVNg
 RdRmgojbawj/FHltiztTJxwZmblfZ8xqxZRp+1jD+7p3bH0jM7Bi7hf6olZPNsNr0MOC
 VROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448441; x=1754053241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4QhPgzDaQW1YoqrScs5f/iteLWSra3lQ7KXrB8CQh0=;
 b=q7mKPW96AMbqJztPQaWKvAATJHrdY2voEk+15Wt1a0M+GK2d7q9Tyg8L8rYBMbJerL
 u14iI5EoeJxDBeMiSvZTeRq0gKTfSm0262DVTLzHWrXTsqLcLBdUvggV2k3DaDzc0PnA
 wd/4lOPhl73jqMbp3dpSR2QVMvvgO/t6ajvgZjnKI6LYE4DMLNgKy3j96AoX9io0lKT6
 FydJyfSyCgmA9YKrHTobjzDYcDvCt/i/uUSisc86LEUfrStmxtlgEk+XLP9u5ShiFkoR
 91fduomi+VI/VQpc7YIRMRD16hDzIV3IF9vNBuql+wVLupM4fDpskB6/FIkS+KUI+tA4
 KTHA==
X-Gm-Message-State: AOJu0YxeJ+LcHI5Ci+QpLXvCGQc+iWjPyyUoa0/CFHXdfGMzs1s2s0BT
 geB/v0UOCtxMKOZjJtjWGbUHu7VrLjKyRZU0iIpAdVFjkYQ/EcDXnNUZmVP46KGKQvcNviizD3n
 q1AMj2lmX3Q==
X-Gm-Gg: ASbGncuq5yV04c8Jj1am10KkFBZ0bBSxwcA3OryLV0W8bPtFkisa971SnwcKzacWhkk
 gnls7Uz7xJbGZLFqz+lsuNiB2F7G107Azhok4R8zpoPMCUL3wLOw3GcUqKS+kbv5DPxCYGEtQgF
 at6oCnAS8m5WD7JL81vnyV6v7T02dRh/QfSlcKpabeWFxtzWu6j4ecg/v6zF8W118IlMeBKK0yL
 nGiEwdNB/h0EqCFQle8seGTXRPpWI707LlsLTMER6T2/BkMfyetyrrA4FXg3U9XwIUFmN3xpTzI
 FccHp38xs4WxwfD3grxCWf/GraLX3oWeL+fX0cQO6dA+oVl5txL+S1/HYfv/K4NTUSdd7pk8ToI
 w1efdpukBPse01emKmiE8n/lEy6cR7z3eX0N33l5ysNzLssZ+
X-Google-Smtp-Source: AGHT+IGq5XfAqpgvVBKrWoP/Z0bX7o4je3Eh0XoxbMuiWf8xP05TdePMt1rkj3bmV34dYhUKplszmA==
X-Received: by 2002:a05:6a20:918a:b0:1ee:a914:1d67 with SMTP id
 adf61e73a8af0-23d70052987mr2844584637.2.1753448440287; 
 Fri, 25 Jul 2025 06:00:40 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761bbede68fsm3808168b3a.50.2025.07.25.06.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 06:00:39 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: Re: [PATCH] [PATCH v3] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Date: Fri, 25 Jul 2025 09:00:21 -0400
Message-ID: <20250725130026.2341329-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723072216.5a34b44a@hermes.local>
References: <20250723072216.5a34b44a@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
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

Hi Stephen,

Thanks for the feedback.

I’ve submitted v4 of this patch, which includes a mechanism to monitor the primary testpmd process from the secondary testpmd. This helps prevent crashes when the primary testpmd exits.

Best regards,
Khadem

