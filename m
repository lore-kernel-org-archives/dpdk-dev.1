Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496AC02193
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 00:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0021E402E1;
	Wed,  5 Feb 2025 01:11:39 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id C4480402DB
 for <dev@dpdk.org>; Wed,  5 Feb 2025 01:11:37 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso1368234a91.2
 for <dev@dpdk.org>; Tue, 04 Feb 2025 16:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738714297; x=1739319097; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GyuvM6TOjQOEUWuMoGgLNCcOou+IEohxO9pXf3WFw0g=;
 b=ECAqKI+7sZg61GXAWHbahbrU4lyz+3eugp0BhuN/+N3URx8Zi6c/3OSCYnsmjO7UpZ
 xY3fJyjwQHkjGQZE6NmO7BZs4zpM8HsoqZMFb8m2xbfH8KfphEAUSz1O6wWesu+rij+Z
 qYHKnVTsRsH9s9pigCxCpzHAedb12ngis8uSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714297; x=1739319097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyuvM6TOjQOEUWuMoGgLNCcOou+IEohxO9pXf3WFw0g=;
 b=faUHoj5pOrXd8H0lw7Bvoh6Rrzx/j2qliBCpFuT1SQlg638C5yF7wcsxEfXLNkctVt
 ZTkP2dzego2ySUaOEjMpMrOYWfEMfYF/vNqHNl16bAemZ4URHLk+qP/IvApDQGNSgxnE
 rQADIU7bHV3EA1ONM9+GIlVcFbpkqG9Auqp+qtQt3ywUtdt2/xcq2YNtQz1hlmZ2xYBh
 Ye8JNiznApBG/HKjvi6S+qnQBXcDFbxF4p3163n5dHDMqgeQqEk3H8ndsq+KOoPJGgAO
 1KgeQP1i+gMfkTNrN6I1BoxWgFIGtYYXZE62paWEQ54pO4EejVmIIYMfenbeF1SgXnY8
 FGvg==
X-Gm-Message-State: AOJu0YzhMWGla2gmuv/Rel+5NkrxSiXKd1IpMtnTK66K5d+1krk0qtTn
 8GtK6Y/ADFb5if/A/GYCsoqq/s5R1pabS9GnOhUK13FGlSGTwoyZqO79EHCMiTw4SOutzFconT1
 uwspRn5z8UzgNR1Ui5xjDI802aY6NFJGokjTImBtVIOqumUIoiWk=
X-Gm-Gg: ASbGncu5+nmnDoyDNzmz1eEJekrg6rXanB6C4oxEHQCYQ86yaW0YW0QysKrKKZ7FaF0
 5Z5+VcLNI4Ccg3hP1DDTG3N7HRp+j6On1SCJTCAiIBfIGOocCOykTwMcST8khKUCtmMB3CGj/Ki
 8Zgmtx5bsMzIqMV4VNb8Ppf291L8Okuw==
X-Google-Smtp-Source: AGHT+IEfBXYcnpF+gkmCG71aAkH6Y9ulKjRiQ5wOvQPdR/WPMKwuLFLulMoaKs8quP8a8hIjw6NC/lkKiDX/5usFadY=
X-Received: by 2002:a17:90b:1e50:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2f9e07677cdmr1223010a91.11.1738714295462; Tue, 04 Feb 2025
 16:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20250131191924.1936157-1-luca.vizzarro@arm.com>
 <20250131191924.1936157-4-luca.vizzarro@arm.com>
In-Reply-To: <20250131191924.1936157-4-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Feb 2025 19:08:27 -0500
X-Gm-Features: AWEUYZnJ7vLevkSdpEZYNXivJODLnHnHC-KiwI4A5Dhaf_CSKOTw5qtQ6VnEwoQ
Message-ID: <CAJvnSUBkU0GwUV66=caMObFUfwtYHgE1nnWJqYJHw6YMF+5XcQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dts: bump up fabric version
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000f286b2062d59f7db"
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

--000000000000f286b2062d59f7db
Content-Type: text/plain; charset="UTF-8"

Tested from a Fedora41/python3.13 container.

Tested-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applying to next-dts, thanks for the patch Luca.

--000000000000f286b2062d59f7db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested from a Fedora41/python3.13 container.<div><br></div=
><div>Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">prob=
b@iol.unh.edu</a>&gt;</div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"ma=
ilto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div><div><br></div=
><div>Applying to next-dts, thanks for the patch Luca.</div></div>

--000000000000f286b2062d59f7db--
