Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA85C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 17:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE52240653;
	Mon, 20 Jul 2026 19:45:20 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 55F094028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 19:45:20 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f785467faso817819f8f.2
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784569520; x=1785174320; darn=dpdk.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n4Z3evfcg4oXpP03gS/57Ue1zqqnbYWkNBC30pzGS7U=;
 b=ECcArqeyrzzkqFZPpNqWeyrCs2CApUDehsCnb+AiZd0Zo9e9BlxaCjQ52RnwlJLnJr
 YS391unWS3qaWSqSM6IawIzuOe6Ag5qyDdMWteXzjs0RJpRRBWhGDphIeCCIcdIu8SO8
 rnPe1nMMiEjO2FGBrtrgWaCQPF3G+Q7yOvI6CSJyk1mRXY+Zj4Omj1x6DV+o+um3n13W
 dIilV4fArvpIUEyCAtSgQuLJ2SM912Vo7el03fIUZyXmlU05nfjJK1L0I/qFs9YDPMc7
 B+NBNA+t+7EEi4rzRiNb+0lgUVuJiIfaSsVJtuXzv78fpMHBy1zwhUTXyJIY7WALpq/C
 x0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569520; x=1785174320;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n4Z3evfcg4oXpP03gS/57Ue1zqqnbYWkNBC30pzGS7U=;
 b=kIVP44CZdtW9Yr5NDz8eiu422ZQxVYFX3YqOrmLosvU9ZYo0DNFOAr9oOGDiQ8rFxy
 1WNpe0O9yBeYvufh07kCazEAY9dGr7OyLWnvYBRJsLX1tqp7BTsC3aVSICfofrHsHqyn
 rEMQMXog0MF2NdVqbG/skfGwGx0BDdET/rnB6O644fKaEECsavLgdlQD7YT9UJsj/Pv0
 fKuA/Ym2gPDGkbjm8hCLY7eQ6ff8o6p0FBURoEsdOHKqrJLqolqxHM++yM37mNIoyDzT
 GgvfilzyKv0d9MP0ViPrz6kbG+REH+LW2kLm863R+uoDWhc0oCJhTuH4x5xq9uGYG+Ko
 JLbg==
X-Gm-Message-State: AOJu0YxeEfvWEysmKLtrzN6dJqK4ZK+CdrHxwodGlQ2FaHdj8NNOW5A+
 TeslPm6ZXHfgxDlSJ3ozuB/BhyPkoCmomQI3tWyGhix/4gpGOwjW3mkAxV7qtQ==
X-Gm-Gg: AfdE7clShxYbkF30ZuGPi8MbMq4O9wc7GcRWvnvS5ML0hlHdXDnDn4l3jz8RMQRQNNB
 0PsVwnu5ms4xrU/WZXnNTCNbLeewxMLTBu9ZmakM/aMmgBOxWnBSH/RPJB669Y5y4W2yArl3GeM
 C8sAy70xQ8ERpFTvKDr7HGyksCDh1a2rb1LDIaMGBxlL7TfLEQmiyfs+CR1TeRNyH8fdIeN0Asi
 FWD8NxeUICXsL7ks+gabpqm0gq4q+8eBNDVMCAEDgkwqi447meFDePgAlzeFh7YiCwhs+Gj2bPW
 +Wy2VWewPn6in3HcyUfFLmZtwwYe6qiHCDVF/gNK2u59tV7/NqM4nFox9YSiiZviMzD7VagE+xs
 7BgJu9RMgy6SNrrPTuEXqsEop9z7gJbzivn4KjdRwNHpGAD6XxvHTIAG1ttIogqBCIH65qIWDzA
 QXFH1xtPc=
X-Received: by 2002:a05:600c:c490:b0:495:4730:15b2 with SMTP id
 5b1f17b1804b1-4954a40d1c9mr165686295e9.31.1784569519675; 
 Mon, 20 Jul 2026 10:45:19 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9845:4301:ca3b:aabf])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49565373200sm5697225e9.5.2026.07.20.10.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:45:19 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dpdk <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>, Geoff Thorpe <geoff.thorpe@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>
Subject: please help backporting some patches to stable release 24.11.7
Date: Mon, 20 Jul 2026 18:45:13 +0100
Message-ID: <20260720174515.3958293-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
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
Reply-To: dpdk stable <stable@dpdk.org>
Errors-To: dev-bounces@dpdk.org

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 07/27/26.

You can find the a temporary work-in-progress branch of the coming 24.11.7
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts or
misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit
in it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:
    https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in the
subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
b1401a464b  Hemant Agrawal   bus/dpaa: fix FQID endianness
