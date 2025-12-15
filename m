Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A43ED5B866
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 21:18:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F2334026C;
	Mon, 15 Dec 2025 22:18:14 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 800624025F
 for <dev@dpdk.org>; Mon, 15 Dec 2025 22:18:12 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7bc248dc16aso3224248b3a.0
 for <dev@dpdk.org>; Mon, 15 Dec 2025 13:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765833491; x=1766438291; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k2ZORqRX5W+4e1jzdNbRMDedElP7X4RrtDhfK5CZH+g=;
 b=Myu/mS15Tx5HfeshI1hfznVtYkyHRwOm9affuY2JDMaPU5NVhnkKLi+GPdNsvEgweo
 Qoaipdxre7hSCIJCX9fYC2u2S43fFVjQNoZ6Qo9nApqsb7raOkXvL3aOy1GoMpoOp8cD
 tZ/Is56odOFPru2C9/23hrIyFDyaU5hzemLt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765833491; x=1766438291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2ZORqRX5W+4e1jzdNbRMDedElP7X4RrtDhfK5CZH+g=;
 b=IJAa390Ok8zoblslhJyDItOd0tPaakhRZDRfvA3Zy0//ku2P4RmPzhuTBJgOmHqibq
 E5OM+Wy5DVBalByYdq/OrkZqX78ZK2j/JIJ3xucoukU/p/pPb60iu95Efnx6jnW9dHDa
 rQx3A+DrdMDjF7CaOw5/RoeWCpQxd6+gBAOeuCC19ftppXPej02RlaMGMW97VvhrsAuL
 qnl755Vht0K2dsQDRXtcQPxtybPMd9EkRGh9AFhk0ZT78C9Gq2vbMaXksL+Q0dTXf8Ut
 iYsPqJzXK/qA7bmqOWSaYoorW0je30A176cbDmkYez/YzxF09Z+ERcYAHPq+PvDL/m0M
 kRXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXGSMAixxgDYR1E1653ztYa31p3YlddCllKh8ZKvuosUqcmsaSpUbIzVTlZeCree2Bs/A=@dpdk.org
X-Gm-Message-State: AOJu0YzvwB/VAhnMq6t2zoSdWhW8rJTgevEQnRfjnH9NAPUtIxQ5Pg7n
 y4J5i4PoreovMagI8saqunnc1aeOSDAEXn2IPyVbZlO5EUYewkHTp7k3lc4Py5evV1P3qto00IZ
 VbWKU0wGm2k8ASXoJ0x4ffJE/DTBG14O6fNGz8XBZgQ==
X-Gm-Gg: AY/fxX5tHU+x/jC1G2na3Lxk54PSxB0E7/7306+mDItfybp+8CZBfozx2Ra6MfmxMbi
 OBsH85/CfYBAlwAP7It3wRZCeso9oPUf+KGKj6lJ1l0kt/fcBMpS9fnfBQJbSPy9lo5IkeqbFsI
 ev4nnpCpZg7vNO/9hWT5a51YfmTZNRAC32sGeA+o33ppkMQkTvU4b0OC7MpMH9f7Olhvtxz0wxh
 pNBFtN3KneXEbVTtGmEANx+g+IRUYo5AkEhqVXKcqPlzgQhKhMbvLAO1ehrVPlyXn2lWi7l/tSN
 Zjm/URnnGVeHRfHujLx/KvwxAjOO
X-Google-Smtp-Source: AGHT+IF5rVvoEhbFNQrpxqSuqGhGpprRXWSqpwu6sdCUWm2Oy+343q+0PeBbolNkn7L+KgkAqaPnw2b8yrhrDAnwVyM=
X-Received: by 2002:a05:7022:4429:b0:11b:9386:8272 with SMTP id
 a92af1059eb24-11f34c2f9famr9097402c88.47.1765833491481; Mon, 15 Dec 2025
 13:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20251212210142.669766-1-abailey@iol.unh.edu>
 <20251215183658.674252-1-abailey@iol.unh.edu>
In-Reply-To: <20251215183658.674252-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 15 Dec 2025 16:16:25 -0500
X-Gm-Features: AQt7F2pAASbwGJXYhTdr_D2vzCFo8-qAvStqTUFWphF0Dd9HUN-QM61Df4ArqGw
Message-ID: <CAJvnSUDKrsNiQLj1q4mpEiPb6CXRr_9kpb1__qX7Mo-b2O1SiQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: show missing NIC capabilities in DTS logs
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000fe1504064604259c"
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

--000000000000fe1504064604259c
Content-Type: text/plain; charset="UTF-8"

Looks good, thanks Andrew. If it is simple for you to see the commit
which caused this regression, can you include the hash in a "fixes: <hash>"
as is described in the DPDK contributor guidelines?

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000fe1504064604259c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Looks good, thanks Andrew. If it is simpl=
e=C2=A0for you to see the commit which=C2=A0caused=C2=A0this regression, ca=
n you include the hash in a &quot;fixes: &lt;hash&gt;&quot; as is described=
 in the DPDK contributor guidelines?<div><br></div><div>Reviewed-by: Patric=
k Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</=
div></div></div>

--000000000000fe1504064604259c--
