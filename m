Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2554BD2D0EB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 14:46:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DE964028C;
	Tue, 13 Jan 2026 15:46:36 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id D593E40276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:46:34 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so6101870f8f.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768315594;
 x=1768920394; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bu36e9CX8ompFhnF+8CuXt7nNz4XnzKrf+QqwI7J3Sk=;
 b=hEAgtmy7iZtH7tvZ5fmof/LwcXW0TrgiwWrtGCM9/WB1UJb/0ia+vff+qpoKD6amJJ
 aHMV5/XdTMt55TXRIu+csaR/sBfWd4hkjB56SjBze8kSDu40uZUnbWq5oA5t9SxCKoNE
 e1owsix5yNOcbQbYR29NSbnDuv4HwSxp50+jrnXOO9BgcthlhiUbNN1yszhj/J5XaWV0
 kn9KE/hR+hm3AErM4WF/zDxJ1Gi0lJrYtwK8EfUdAvObFxnvH84gcRhiQmHzr6o5j3Mq
 BUQ4XreXlcdJ64lGPPiuMHrXcJ/M2L9JsCt48zx8NSfqkmuwkDrSy2iZmulClVvHAZ6D
 uARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768315594; x=1768920394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bu36e9CX8ompFhnF+8CuXt7nNz4XnzKrf+QqwI7J3Sk=;
 b=iul09pUuxWAe4qHdMnJyfOAi59Gv9nZmTT6djoDBbzxq1LjwfKWhMSlx2Uc6XPuVzN
 LbZsEDaz7IlL72d3nCrNmn/rP8Tgy9iC59hrJLyuhJLTvrDK94Lq7ngSHyr62PWhtFeT
 1uZ4muecXy+vsB3DqPXFLxRbja4WdejK/FgrvOW9Zjvl+vSOlfiDDpRRGkhGnTooR2Sd
 hVNn9htID//zuvAzCjahTonACcr0+XqXiUTmiDE+Ouqt+3noakfnPSQe2nUCwy25ViyU
 i5Q4Tdn/D9J4T/+f4qxEYQBFBsvwNKupyw5mIlKg9wndz2LunRnSCxkEkgmXq1VkBCQf
 lQOA==
X-Gm-Message-State: AOJu0YwjW4mMxYSvOZzuPMrNC3NoU62XHVUYc0OiWDEtlDej1NYdBzwo
 SqbAMFTwoodRepyhT2zXX4IdSoVQWhsw1kZpV+qiwyumBjUUASWjaEEp91i898SGS5Bp6av4Gi4
 hRoIl
X-Gm-Gg: AY/fxX6YCNMFlCKab87QJ3gzvoyd8MrFp6WmdDglWL2WdzniedQjrJ8DU3zj3tCng0H
 ztlmKBS1NoPVJZW6FLzt9ibxYNBmjPjR3US1mqTq0nO4Gg7kjrlW9pMbyZkwYlJ7oC9BL7giPly
 piuO+yiH1YDbFAdS3RDUi3nxct8whnmm+3IrlBb2PadHfnB8/m1ZC+lpc+UEtTS4XAmfNCUwD/z
 ElU4juNb1lLRy7fPvkb6hRRIOltzYuf8Ffe0hRDmyyg2bmNaDtZqeVy9+3+uACdoij1XvUR4B2f
 32+hgQ03YuIPCw7t7CS1zJkpHspY4GYDdZRS9Dw84BwLjzYVrJe0tXvRzmzKoCm5r9Aze6XBo4X
 V5brKWTpm9fA/n9I1CCVxve4Q4qrr9pYCAoN7jGFzGoZ7XawAme3NZZH5g3/5qEH8MvSK5kEoqA
 McvdK0mIJXq+T//gddEy6gGDrXEHa6oe/J787oejrWrq61ZgnHgV/b
X-Google-Smtp-Source: AGHT+IGe3BFMtw/Kkh6CM7IPKfCTatmERzXM7+irkxCmKhe2EKDpcoh4VTFrylgBh8w0XuhResArkQ==
X-Received: by 2002:a05:6000:a91:b0:432:da3b:5949 with SMTP id
 ffacd0b85a97d-432da3b5d11mr13061158f8f.21.1768315594282; 
 Tue, 13 Jan 2026 06:46:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff1e9sm46445428f8f.41.2026.01.13.06.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 06:46:34 -0800 (PST)
Date: Tue, 13 Jan 2026 06:46:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix issues reported by Coverity
Message-ID: <20260113064628.114ba10a@phoenix.local>
In-Reply-To: <20251030033619.3386064-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
 <20251030033619.3386064-2-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 29 Oct 2025 20:36:19 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Coverity issue: 490942
> Coverity issue: 490943
> Coverity issue: 490946
> Coverity issue: 490947
> Coverity issue: 490949
> Coverity issue: 490950
> Coverity issue: 490951
> Coverity issue: 490952
> Coverity issue: 490953
> Coverity issue: 490954
> Coverity issue: 490955
> Coverity issue: 490957
> Coverity issue: 490958
> Coverity issue: 490959
> Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
> Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
>=20

Automated code review with AI spotted issue with this patch.
Please address and resubmit.

Patch 5/9: net/nbl: fix issues reported by Coverity

Author: Dimon Zhao
Verdict: =E2=9D=8C Needs revision - bug introduced
Check	Status
Subject =E2=89=A460 chars	=E2=9C=85 (40 chars)
Prefix correct	=E2=9C=85
Coverity issue tags	=E2=9C=85
Fixes tags	=E2=9C=85
Cc: stable@dpdk.org	=E2=9C=85
Signed-off-by	=E2=9C=85

Issues:

    Error - Dead code introduced (lines 41-47 in nbl_userdev.c):

c

   ret =3D ioctl(common->devfd, NBL_DEV_USER_GET_BAR_SIZE, &bar_size);
   if (ret) {
       NBL_LOG(ERR, "nbl userdev get bar size failed");
       goto close_eventfd;
   }

   if (!ret) {  // <-- ALWAYS TRUE - dead code!

After adding the error check with goto, the subsequent if (!ret) condition =
can never be false. The if (!ret) block should be removed or restructured.

    Warning (line 53): int ret =3D 0; - Unnecessary initialization; value i=
s immediately overwritten on line 60.
