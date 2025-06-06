Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCC7C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6CF40647;
	Fri,  6 Jun 2025 10:02:54 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 23F684042F
 for <dev@dpdk.org>; Fri,  6 Jun 2025 10:02:53 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4a4bb155edeso23219081cf.2
 for <dev@dpdk.org>; Fri, 06 Jun 2025 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749196972; x=1749801772; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqXXNTzYg3Lujo1sx1COWncLlYSonIBH/zES50VFfbU=;
 b=HESRamIYv/yXbmRTTkOBcmFnD7KJmRkqIbiFYCbHS63FvvyPaKX5DK2Gx3xviiHtVw
 dtPNm/MHsmu1/vgcqcl5uX0zdnijd3rGQUxqn4niM1X5YdMKuT0e4dLD+v+Jt4k/JfbG
 EgNZU1YJ1Tnu1Y6a1pRqSTCtji/T57sbaO5McKJjf+KsKdapnsyO1B7HqGxIRilkCppq
 54MAeCOcx0OARB3Gg6WtHEdJBQiXpYPJnfLTIiI8/3a9SJH1o91EAZ5JFoLjg+toKSRl
 5KLmL39cd+L02TxbfFQr826Tblb/nHYNI7dd8ons8uHj3eEYgTQEEk9I861gxLKuo0EA
 1sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749196972; x=1749801772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqXXNTzYg3Lujo1sx1COWncLlYSonIBH/zES50VFfbU=;
 b=udqnX0F5RPeQo3TouFZ4UyPRFlnaY3aiyhdBMog3tMyM4Pvqj8SFtWbQU9hdfn8VOv
 +pXOLBL1wRV6mHlVg4npDuDNScJkSVYt/fbb2NT62pA8FaYjzhccj4DROx0B028aqQTB
 1zOef1LOrYSXT0qV4jkHvzMVx1C7pJocMzVBDcAxxEmNmegDqT13U4iqRk/OALjBp0LJ
 WAB0yfKldGtvdjEBG+qDAbO6TVE/uMvPhNzUClcL8Cc/AzEusx6OEp/PkgZY3IMbTUYN
 UPblfFBaGjrSNtsbBu7xmUjKRh7yp4zC/PKgDnFOWv8slu3SyjPZ+YHwkaS9B25khn0e
 67Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBd7oH/7lhpcYw+/9keqvFjwnlfR/dy8U6azMgmzulEJA48MT/s6IqlYpMnJP4e45iRpQ=@dpdk.org
X-Gm-Message-State: AOJu0YwtbhH7RAx+1eNMaSkhakrcgwYji1ja6JcAeREph9DaG4nUNnCO
 CWa5PQ6K0aLh0OPa1tbR5o6DKbLZlWNsfpFfhSkSYKQ9YA94sJ5qPoTqH60kSjNDCIJOEuw5tY0
 //wkGpUMePtqUwWIJv3+SfrKVu+q7Kug=
X-Gm-Gg: ASbGnctWWq/RCVUs2QeugltziR2AG4pp0d830DC94nxisJY4K4/K9Q4idqeMqv7VcGZ
 AvP8IxUvPN3ZJE8uP9dDyBRbhwSpbMNgf4t3/q0ZK+7ZKk/wdl7KzChlm8CNxv30Dxd+4vAcNFl
 akO3qf1YwB4Jfo6jcP/HDwERGv5m8T4KZFlL444F2Qmw==
X-Google-Smtp-Source: AGHT+IFzhOPQdjhHtGLu13rc5go0x+k3suw7s2Nd1EDLO5IdgTNOuBfzvJz0r2tOgBsL/6wDOsDCwea3nnASgJ9cKiM=
X-Received: by 2002:a05:622a:124e:b0:48d:50eb:91ca with SMTP id
 d75a77b69052e-4a5b9e21071mr41511011cf.15.1749196972366; Fri, 06 Jun 2025
 01:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250605173315.1447003-1-nsaxena@marvell.com>
 <20250605173315.1447003-4-nsaxena@marvell.com>
In-Reply-To: <20250605173315.1447003-4-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 6 Jun 2025 13:32:25 +0530
X-Gm-Features: AX0GCFsIX_ZIiR-9TA4Y0PGCRYHLjM6UA3P-W2Ci-p8YvvD_rdYa5n6rLd06HgA
Message-ID: <CALBAE1OFLqdnxscDwYUSwV2shGe6k4_o3jRNToBGCydycTg_=w@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] graph: add feature arc init APIs
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
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

On Thu, Jun 5, 2025 at 11:04=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com> =
wrote:
>
> This patch adds feature arc init()/create()/destroy() APIs. It also add
> APIs for adding feature node to an arc.
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>
