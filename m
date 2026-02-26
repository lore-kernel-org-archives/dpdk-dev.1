Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CABFD461A
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 05:05:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8FB24021F;
	Thu, 26 Feb 2026 06:05:56 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id C7D93400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:05:55 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-5069df1de6fso4123591cf.3
 for <dev@dpdk.org>; Wed, 25 Feb 2026 21:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772082355; cv=none;
 d=google.com; s=arc-20240605;
 b=GDM98sEHjRC4p9ZNOx5bxVVSpCVl2RKvQ4Nw6T6CTbLJuyVo4E+zqknu1G1t2vF7sG
 rWuhXVrmarjVqyoo4fFsVTq+diDg0huk0BRuRuxnYr80z0dMUcR5tlTqnJWD++L9Nebp
 yr7mcKzSnWD3TUccE0pc4r0oEDz/feIvDzs1iWZbUaySAFeNzYe8R/fpgIoYO1+9Dq55
 NfEmNClPSdSBGlG2MMzosHMZc7W5VQq577UfKcZ4NQkCRhbkmDlTDFGpkSRr8px1R0Cc
 QzPoap1nzLvb4Acjt3n8wVre5MtS9Uvy7BO/q8r9REZIfpz71eDYK03WEfnX1Ssk6H1f
 5xEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XjXZqEOP8xGRryu8ETb8mTdwO8l58WUPUEE+xJe6qPM=;
 fh=AWWq3WD50/hRgQhFlOlyY9e4SLNDsnHrLOnnoS81ZUI=;
 b=BiBBTOCXa0EF3+MxfyeinAZ0B6CB/ABSNkNjQNDDzXwl84jCXlcPUnOY/r5Kvv4V+d
 4SHFUrXMxuIrTP2kY6fp32SnuoIrvmpC2QPQb463CImi8eqyUdZ4PS5aIJ5mdEl27PD5
 NfNhz8IHvIfeZ/NIkTP+lY+EmZwwgi0Q6dQlgSV+W4tFszl9fT+IjYVTOtZf7QKWTVdb
 BnePhjAovzHBSgq2/f6aciK6/PqZgZhOnaY5NmY11/jmzR65J5FCFpx3wQidQDAjqB2F
 KHz8OFpA8pXZsGadlIkxf38RPRjCRqtdcf5MCdRk3hkTfTbItVsHICjE/QNPot8A5F4w
 8LzQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772082355; x=1772687155; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjXZqEOP8xGRryu8ETb8mTdwO8l58WUPUEE+xJe6qPM=;
 b=MObnk3EV5jf9nu2jFrGCG9XsFVDkrsGEpGu/ayrjLOGOlwCEWGKidrdaDaVSJLL8Ah
 DM2zmKaAelUPVeQFf6XpCSvnz0ykvQTkNBGit1o1dU46FwFmnNlXCiQ58Ugf5JZqSKC3
 XrKcslrOCNZkbn0OZdpaXBePQzVYDspmDISUkhVGwwVtyRZtphs0vXIUgRFikmrj/YdX
 YvYzYSRrbTXWTDWUnxpHMsnueUgC6wtAQ06kRbvZ1XBPkg2S8oN2i0ISuLfM0jyCbdlZ
 j+WWAMPcoWJ8IZKaMMmdV0YoFni5NYI/TJz2zAUdcznHb+PnltnAJAkxj7MGFw9/AME4
 apSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772082355; x=1772687155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XjXZqEOP8xGRryu8ETb8mTdwO8l58WUPUEE+xJe6qPM=;
 b=VQWK1KlfV9SwhpfLeC7++x5lCIvr4sjFduyhXlZZnVKCyVYzPA9MuzK7AG9EGSJArV
 Xla06srsTpNbacLrOe3Qs06vDGQAGKn7LEz7nBoe/NNfmYu8bSPjGDKr2uWHtOot+Y4i
 EOpstHX0NAvN373WoOrWRW5Ow+nXsz8z+M+bdocUo9akOCZatrGq5XAFR3mtPcGHOYJY
 ivDDpZfWgLEsk+sgGaEpnpaWSdoYWXwUKj1WtM88BX+MG7AHoYL5onko428X822MVYGg
 F4f1AoC8FOKsbfEPjrU0Vv4Uva8YIgW0KksWF69Dkc7aB5P7OCtiQ9UW7KyBevqaMIp/
 OzEA==
X-Gm-Message-State: AOJu0Yysm3rumCJLmpLgesO7fH/cT7mrRabr4GFCS7T8Z/UfHBCB+rQ8
 +AGwZBH0UA8euIvsUpFcaoI3yhq0rHfw0/ONQGaHJxSQqwgsOC9XH5AF/MZYreT3xzzI1S0UUgA
 g+Ypua61zWp/5Nwzx3/OkuVAuWRzqcNI=
X-Gm-Gg: ATEYQzw22tonJPJ0VPX7ScjteNbx1SXt3dICbRLzYzXsnbErFZdozk4Iv9Qa2XG+7Jx
 G3+YKqVCYbGKN4TDYsVvedJvc1esYgg/6pkbc/2NTvlZpZNR2CJ4hujJM67Pt64ekqHJtkmUIjJ
 IKHrCevgVpO+h7CSWyYUdvA9u5ZH8BY7NHe2ZEuKG1qNXc9/UvMMrPtpeAdg/VOF9wBuDsNkDlW
 GrRN7jH4wBa8LVeQyxmButb1o/8Wkg37+9UgOuDjZsek7P8sCF6AaferoHKbt85dF2zC6D0/6xW
 VDz3o/e7CZF8HGcbjg==
X-Received: by 2002:ac8:7f46:0:b0:501:17a1:4ccf with SMTP id
 d75a77b69052e-50741f0614cmr41270141cf.3.1772082354965; Wed, 25 Feb 2026
 21:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260219090847.3257753-8-rbhansali@marvell.com>
In-Reply-To: <20260219090847.3257753-8-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 26 Feb 2026 10:35:28 +0530
X-Gm-Features: AaiRm520k9fy2oXpmr6roUJhN5JqvWnnzY9iQkOHoBYjQKQinRjn20kOc9LkOF8
Message-ID: <CALBAE1MnJxTLS91-d2w7anjJjZG3uJX=0Tjcwz49z5ZExti+XQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] common/cnxk: enable CPT CQ for inline IPSec inbound
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Feb 19, 2026 at 2:39=E2=80=AFPM Rahul Bhansali <rbhansali@marvell.c=
om> wrote:
>
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
>
> Added support of CPT CQ configurations for inline inbound IPsec.
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Fix

Wrong headline case:
                        "common/cnxk: enable CPT CQ for inline IPSec
inbound": IPSec --> IPsec

Invalid patch(es) found - checked 8 patches
check-git-log failed

### [PATCH] net/cnxk: support of plain packet reassembly

__rte_internal must appear alone on the line immediately preceding the
return type of a function.
__rte_internal must appear alone on the line immediately preceding the
return type of a function.

7/8 valid patches
checkpatch failed
