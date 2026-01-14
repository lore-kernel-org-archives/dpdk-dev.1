Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F7D3CC84
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 23:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D41E040E78;
	Thu, 15 Jan 2026 00:09:28 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id DF921402A3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 00:09:26 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1233bc1117fso375863c88.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 15:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1768432166; x=1769036966; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DX/he4+1ITKNsQNmZcgpbL5LKz8KaBeBHh3M4t2B6x4=;
 b=cDxW5x5bkn7L+klOSdHdeyfRy/2/Iu+ytA+sdBibTsf15tDPGJy03DBqc0znawGDJZ
 33UDzVbcu6JsjHAj8BOBxEn8tRbycPd8AL9VUbhj8a/9mE45fcvS/mNE1PeMo/lJ3Uli
 nfa/IbzT0QxZ5zD9yOitKJJRdXE1UGVxz4MOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768432166; x=1769036966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DX/he4+1ITKNsQNmZcgpbL5LKz8KaBeBHh3M4t2B6x4=;
 b=Y5du52NtrHHvWRiacc7P2Ku2WZ9l9SRZiWwDC9yaakmmc6GOMUV7eIrN6x7z2oCjIc
 e03Ov4LqEwJWyM7sg31LiB1HUr7ttUGbUFFsfpy0a2YAWgriOMPEMR+D4+OddJQcgj1l
 AYzLnHdgWutzoTeKumAcRH1shzDCfmz1w5cFAsvKQ8n9yFNsBUq1olTKiGsGCAfrfaQi
 C2PBq1rWBYajrRJAioljEJK+9DmdgTnlgJoPEVzlN9ocjb78xOGjfKToPC68uW9aXjPh
 tr3pY4kcFjo+Pfc/dOiW4NMKUP5FGoSuVo7wdEWoQb9kSVUuZVNHc00ZGVTKw5IjbXjX
 w+Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMfILvflxSQWztIA1QwhYqCDCZN2dHr0wQBW37WB7aHIhmExIvSOCaQKRFmDk0218b6Es=@dpdk.org
X-Gm-Message-State: AOJu0YyVXfSIqOPwkZJjxsfrobwFwPFU5vOBFpTv+4LlxAHPwAxM1bvC
 H/9jbRTsbhGSiEIIXUilvErRjjF95HC8VJ3jOT6EnrA8ucigmP7FLJGsrR7g/Mkxm5Fy9LkkX85
 QZ20pA/av8SFbhC4UcsoVO8+MDbDJm4Bdydl8DrPUjQ==
X-Gm-Gg: AY/fxX7ueZds4TQqcGkPW47S0esl3g6d2bDMoXc33e26JYEWK9UvmPNbjHrBHe/VOoy
 4Ew1SRCXJ+wdb53e3HHijp0E2JVf1UrD80YzuSVZVLx/pHfZ3QGaMdYn7FdwUMmncHb7rRmnHhG
 Kp6tgFRvkgWXCMhTBQjguIjFBKQb55pNJ2PmYNiWnA7p1LW6QjjayQ73ZMtKXR0+F8sG/4TE5fG
 aVCm/x9LFg5aCbk8iK3/LFKUzydH0rk624/Y4odnPhFeReobk6kS/zMoctzdqpbt9J2MLTIE66L
 Udkw2OAArBwN1CtA29U6u+fMSmrsjipW4v427FiCySa1KQzEOEtc3E6+Zigr
X-Received: by 2002:a05:701b:240d:b0:121:d898:edae with SMTP id
 a92af1059eb24-1233d08920bmr708451c88.24.1768432165843; Wed, 14 Jan 2026
 15:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20250826200720.104443-1-dmarx@iol.unh.edu>
 <20251106181355.209706-1-dmarx@iol.unh.edu>
In-Reply-To: <20251106181355.209706-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 14 Jan 2026 18:07:13 -0500
X-Gm-Features: AZwV_Qh1TvXrWjS8Zje5W0Ils4QxiU2tueqZTQ6dTr0_q-CAzkE7bmX7LfEkVRE
Message-ID: <CAJvnSUCGngke1yCpEG5QuzHTEk681pg6600VMNi2g9X-OzmyEA@mail.gmail.com>
Subject: Re: [PATCH v3] dts: add test case docstring checks to format script
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000000e06450648613369"
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

--0000000000000e06450648613369
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000000e06450648613369
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--0000000000000e06450648613369--
