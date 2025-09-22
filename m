Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B491CA100F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 21:46:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5840D4042F;
	Mon, 22 Sep 2025 23:46:21 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id EFCC84021F
 for <dev@dpdk.org>; Mon, 22 Sep 2025 23:46:19 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b55562f3130so785196a12.2
 for <dev@dpdk.org>; Mon, 22 Sep 2025 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758577579; x=1759182379; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i6yL6M9ZhbSP/bImR+AmadJx+oOWp7AasrugcrhZt1I=;
 b=KLwz1e8oITzdm+viNCrkckKo4urnRNBTqsx964zGvp8jZJOIQ3E/LpXa0NdgXa2OIQ
 IFgRLEDIiKXJr/8f5xSmPNXfo63qOx5uRjumEHSFkHAMP7JSdkMk/vyCVj7+LA3lq2SE
 HrcZhb1rpKeQTiSJG88CnD/rzPsfbdrLpE7iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758577579; x=1759182379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6yL6M9ZhbSP/bImR+AmadJx+oOWp7AasrugcrhZt1I=;
 b=Ycs13CH5bAlPBRPEPIdxHxRHyQ7/F91ggnBtcTQhoK0LczqgxVjeddlo+iGNGTVsBr
 NzmIrwb18T4oyPZeVs86Ftzy6N2Ea7KyFhklXqfmvF9Y5AffAlukvTchYzv0iIZWLggJ
 aVljs7FZd/d6TjkvmiGsiCwk58RL5/iXXb1++hGl3FFHJmuiNZrvw1vFoc8stU10Lkv5
 BMHKHFAp3im7MQkzZ7o5E9fR51SNTAbGB3iVDug7YvJf0e56bAUDllrLUzssd5Qm4Ogn
 KKGF0FyMQXXz3KoATJAQhdbhYkrUFl0N1VdRFoovx8fKd5wc9ReTVYvyA8Nd5ZlDpM9u
 G76g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9aHomlu50wTLSvKATUHVxY+xWfh1mUynSJlhg+GFffeZ7BQPdLpdPZr2Eo7FmnXiPV34=@dpdk.org
X-Gm-Message-State: AOJu0Yw78BE7E634GjJp0slHsFZhfcCLs1dcjh/BsrTI9g2Y9vRtUQKg
 3ILhs+Ahk5/WCqfEVw2B4tVZFG08ooM0lA6+mbiITpgYEh5Y2HAmY650VF9B3kpRAlNYFGs87jH
 NNWnoJqq+LUrY5AQrAT0MyB6KR3yVsg4KD2rLPQQ3Fg==
X-Gm-Gg: ASbGncskPArLQI8sNP9nyWVmZRzIdhXaGxor/HrH4A5C3K3vWPAJHcztImEwvePyZF4
 gxWtOS5owqb12Gaxnd6RQlElMS0YYE9vioy0FVbDltIZi7/Flf3i6ssVW1upRpHEAjoiy6e3D9v
 ZHREyBqFK6nxuLtmZ+rGUNtQPaez0+w0Q3IyqjKG67xxZjm0s9a8kmlOBr+mZM5dEAsJjNz/2wY
 Pcd//onqnQunKldAsNNRJwRfSUj42UrZKMGDJWK
X-Google-Smtp-Source: AGHT+IHLSwzMnU0uKIfoN5r7YQ5Ao2rtGDQb+5aur4aUwsNtiK4qkHxACUQb+AchDTslccO4ovODtVFCllCTyt4yzg4=
X-Received: by 2002:a17:90b:2d8b:b0:32e:a54a:be5d with SMTP id
 98e67ed59e1d1-332a91baa9fmr446813a91.2.1758577579003; Mon, 22 Sep 2025
 14:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250910122749.8277-1-abailey@iol.unh.edu>
 <CAJvnSUD5raC7qtXzD7v11wHR0r2XG4+5hm+UcCPo7H+Oa=QuFA@mail.gmail.com>
In-Reply-To: <CAJvnSUD5raC7qtXzD7v11wHR0r2XG4+5hm+UcCPo7H+Oa=QuFA@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 22 Sep 2025 17:45:59 -0400
X-Gm-Features: AS18NWCNeM1AkHUa5HPL5jXij9zCSjOnVHNN4ScqMcqoKPsa6sqw8wOn1vVaJ2k
Message-ID: <CAJvnSUBNuapzgfutnD2snh4xzZsjrsr8tm5Y0opgH0nHT5SU=Q@mail.gmail.com>
Subject: Re: [PATCH v5] dts: enable port binding on the TG
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000e8227c063f6abfc7"
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

--000000000000e8227c063f6abfc7
Content-Type: text/plain; charset="UTF-8"

Applied with the commit message fixup.

Thanks Andrew.

--000000000000e8227c063f6abfc7
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied with the commit message fixup.<div><br></div><div>Thanks Andrew.</div></div>

--000000000000e8227c063f6abfc7--
