Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07028CFD313
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 15:46:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECC56402E6;
	Mon, 24 Nov 2025 16:46:25 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id A960D402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 16:46:24 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso3873999a12.3
 for <dev@dpdk.org>; Mon, 24 Nov 2025 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763999184; x=1764603984; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DVMcP2vNUu8wa/9cyJXBwU09TaFBNyIox3qkyy48DFc=;
 b=A2mj6LRirEPy+hAWqobja/HfTeRV0f+etJyZhUJbloVJHlIZSGPfpSB0HH9lsOdieF
 DKMtNNZTXkdcvOyL8zlecQ++FMUBilrCbgwbXsNNJ8RTHk+pPKqv9V6s8oURt3hGc6rc
 C/LPdxEvoRB+mihh/OXxm0f3G1/I0H4/kzwSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999184; x=1764603984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVMcP2vNUu8wa/9cyJXBwU09TaFBNyIox3qkyy48DFc=;
 b=ifDtiIXsB9a01lPv+NrscxwuG+a3ZWupgjHKH47ynQN3UnAHi3sNXFW+DEXLh2+//B
 5yTAUpo2ISLtXIOkyEPYYcZv2iqOTAxn2sz0UOfNHw77Wb18NnetP+b8r3w0UhrskEBB
 DheDHCUPkDKdI6ZSSyPy+VBV0N7WdU8PoxG7+cYLi4EaV8MWFAH5Qwsrs0HuX2PnKxZP
 s0fCbLllumZLXu6lhiP7KbclsAw4mhA+quGMQ1gsFmR0JlTjlnxOxbuX4oF2myx5zP3g
 uLG/2ZvjwHHLQ+eEzNaZpFgU913ZVNKq1X/iiKsHfc29TpSP6LhZfsynPVhm3o48EPJt
 zcXA==
X-Gm-Message-State: AOJu0Yxj/T9m3Z+jlG4nKwMZpobPCgdMiYrjJcIW45Oo68ez/DZlYVGD
 uYZ2vNB5DcpCFoA8JtAyu4hcMq7UOOqeWwIVwHa2lG9WuYYMkGp2AbkvIlBHGAXQY031aheXEDS
 i79/BRX9inPq1HtvSF7O7DiB3N0py9ms9xFX06nEhYMZh2eQJRnpggMtQiQ==
X-Gm-Gg: ASbGncuOOaJ7UIN47zWjXqF5bTpxCshCiyjtQ/mVV+TCQTwQAscgolLoDiWryEyDTKV
 GZGTtqd17TrOKloRkTFIq2LqY225xQnN4N8oT7HKx9ZKznyiq+TuNjg5JeFnQuUq1flj30idV8O
 vLRQ0iDxYUw/cPARg/pFMg4zXN6Lfi+RN8j1zyhjE80A+zo04zhFAt0EzfSb3Tsnu2f/lEm/oTq
 QNqCd3ZAusSxS2K453xSYDz+lHkZZe2exOcUPiWwjElNNZ0XkMAoov0D4+rTvGKXppZisAO7dtP
 uO2VyFMTlyYGtqB+jcUcCwmQ4Egg
X-Google-Smtp-Source: AGHT+IHOqGFfIdixTYwE0ob2XaeIQNnPwxVSWELy4k0Oi3fLebgJEgC0mEF2gsnulPzpetIMPO4b6fKQ9qq3MDvUpUI=
X-Received: by 2002:a05:7301:4d0c:b0:2a4:3593:6470 with SMTP id
 5a478bee46e88-2a7192e58fdmr6531603eec.32.1763999183531; Mon, 24 Nov 2025
 07:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
In-Reply-To: <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 24 Nov 2025 10:44:58 -0500
X-Gm-Features: AWmQ_bnctxSXZpV8IMNzDWM21LpET3OmsF3UZb9ojncuOA7m99KEtXOzp_mJn34
Message-ID: <CAJvnSUBk6Y=aznWzO0M2U1FFVMQJBkLNxfvw2ZF01xW7_rCRDA@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] fix NBL Rx VLAN issues in DPDK 25.11-rc3
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b8017c06445910e6"
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

--000000000000b8017c06445910e6
Content-Type: text/plain; charset="UTF-8"

Hi. There are some DTS failures on this testbed due to misconfiguration
applied by us at UNH last week. I'm fixing it and rerunning testing which
will update the CI checks for your patchseries.

--000000000000b8017c06445910e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi. There are some DTS failures on this testbed due t=
o misconfiguration applied by us at UNH last week. I&#39;m fixing it and re=
running testing=C2=A0which will update the=C2=A0CI checks for your patchser=
ies.</div></div>

--000000000000b8017c06445910e6--
