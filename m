Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436FCCAC5AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 06:39:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59E3540608;
	Thu, 25 Sep 2025 08:38:59 +0200 (CEST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id BB9C940658
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:34:40 +0200 (CEST)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-62fc89cd630so338453a12.2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758746080; x=1759350880; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5DbUnSAUc1PCS857u54sW8on1r3o2c4syRBvLg5TtJQ=;
 b=QMCcmaJZR2ST5ummhDwom/GK/965IUZqCMQSa8d4+HTGXtc0lpCdwIRiocwzH0Ozqv
 31koS4/zDUd3l9NHhjOBcK9Zjh5cz0DQO0b2ySrbwSEaYvDVba6Cwh1kU/hoYvc2Q8TV
 nrLMcZur4VDakbEEmKnCnPKFiudhlpPBnpeiBZ+Dx1wWyq6jJpuTe0Va5KKHLr+ZLdf6
 LYTzw+x2sHkLR4mt9rznaxm4K7TggLv/8FZ7Shjc4eonCfC5/gDdP1mPiA7UUlsg7W36
 dQQMSKvoKJ41AdvZPpTfqu3wrU7vlKrelTKmybaiqkkZqafZEirjkcYmwFRxDFIHIsdx
 DjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758746080; x=1759350880;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5DbUnSAUc1PCS857u54sW8on1r3o2c4syRBvLg5TtJQ=;
 b=NdiopTN+Kzku+q1447FZduGqCZ6wVx4IZEEqnECzGfSI/HXLhQx/P6uPF3e9fFp9Oq
 2A6ueHK1S1EU/86ylPMSr5230zOgCoQ6/8IJldvGpE8qe1vlkCvaRnJWHDf01TWnl6b0
 jSiXHZRR/AqeptCLHYPbMWOS9j5DTqk82qZtdV49saSSbAC4IxY/2CNgw6PkCrbsqWqq
 oo30mtzBXDYbOQSTUA03CFk+nlDFtoJw/eVbmthoTPBCoxMXxW5nx5DV1wuGhEgFuG8t
 CAnSsQWHtUoXtPMgECw9Tw3pX1crYtJMGyJmZIO8ajeEE+ISOMcDAVy145ApWkYGoou9
 kv4g==
X-Gm-Message-State: AOJu0YwecipWZje0bVRXV4RYLq27Qy5iKee6n1Qg8st5wWZg74LwJctZ
 LynOKKcX21KBTVbGzJ0zdCB19MLSDd9vZ33KqDD04nneChVbqhSrjR90qfh7SgJNboXxuIropqD
 FQU04gX14TZUuXeTWQsyFHTHe/YJD3PJf4NPQ
X-Gm-Gg: ASbGncuwTf0WCoh4ed0VSTnDd2ngcq91Ba2bnHm1qBiQA2huMWJeQ494uf1l0Ua9VIU
 SGpjNOxA18BOeCkeA+c5QvslLsk+C+g397NCOWfOI7LMScxFvWfLLjlyWtfmivy3PmQfCIisK6T
 qVe+Fdz7Aw/Sh8/I4sJgh74s2vCi85X+xnY3ZsEe40Oqp1G2iQxJEHV7HNtGVpGPR/jnWM5/8md
 NWs8iqe
X-Google-Smtp-Source: AGHT+IFHeuHmumveTZJXvMNe7vf6HiflHavsugaf0D66iviGRqJEqMFIP2QiNC8PAPSypnSGI6VGZiDeRWj1jWCTss8=
X-Received: by 2002:a05:6402:26ce:b0:61c:8efa:9c24 with SMTP id
 4fb4d7f45d1cf-6349faba88emr612741a12.37.1758746079869; Wed, 24 Sep 2025
 13:34:39 -0700 (PDT)
MIME-Version: 1.0
From: Ly Min <lymin8462@gmail.com>
Date: Thu, 25 Sep 2025 03:34:26 +0700
X-Gm-Features: AS18NWAO2tOHG3zqExYelWxVWO1g6edgFTSg0TxqYiwlLdk20OvUJbsFBPwZrQg
Message-ID: <CAO-XfvYExj5VZ0iiEz1QU+7cGFf251ppMVoHhpX3pz54S1E9-g@mail.gmail.com>
Subject: Re: [dpdk-dev] [PATCH] examples/multi_process: remove l2fwd fork
 example
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000573d99063f91fb82"
X-Mailman-Approved-At: Thu, 25 Sep 2025 08:38:56 +0200
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

--000000000000573d99063f91fb82
Content-Type: text/plain; charset="UTF-8"



--000000000000573d99063f91fb82
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--000000000000573d99063f91fb82--
