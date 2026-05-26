Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F08CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 19:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0270A402AC;
	Tue, 26 May 2026 21:18:19 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 38FB64021F
 for <dev@dpdk.org>; Tue, 26 May 2026 21:18:17 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304997cdb21so2708920eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779823096;
 x=1780427896; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDLjqUEs6mfx4F88eyUwhXlsxi6Iu0ULddXEAVrkoeo=;
 b=QJDhLintWpeY5dcdY8ndJcCvx1Q0gezujqn++qYjHwxKIQDK5ZTNTwVEkyFHJmtlYD
 wVZ2BzVyTIiSLowJr+ApE+IiErO0WXIIJK2XvMV+yE4Ax2gHgiircJKgEX2b1JRHb3Nb
 KC6feiAT46pW/msEfqqDeSlsNdCRGtexJCF4zJVpSy02Tv8mOQO6RttwZ4Hs5U8TnOcG
 2FYKF8AnD91Kk5kihnaOJB6KmoETjVO+rZUOHLE3tTwMw+XealY44B1dxlGq1W7E9PT7
 0Bg0n09Wojje+RxJSTN1bB8d+VtbeQ32J/0CZ5LnLfY4UBU+/jNHqwUr/MvglulxnSVe
 HTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779823096; x=1780427896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cDLjqUEs6mfx4F88eyUwhXlsxi6Iu0ULddXEAVrkoeo=;
 b=jautvpY4e1TthjbdofFddgUEaRE9lzelWB9LpBuAfpoq4SqOYydt+R49WPNUdaQZig
 mJ+asCghZaZGewapgUTFtAFxQ5oOXMqg2AJJ6CIx8ORwtsrf0sy1KOQZaYNaEH++QCgk
 q8f3sJFHlEBOoewX34REc9CDlIRYvFyXPRp95BpG8hJ6mTdHJm0o4P68wEdSuB9xiQwU
 qxBxsg+f6qhi3yg1s5wLZOGoxzNlDaaDswxjz213cjTMcRe2brqz4CM9YdcxlttJXOyU
 Yay6HwiXFqWQt9h7jwuDIv2/WefUULlikVdGXu6LAaJQpMgE8pdrgVLJQxsnR1Dh0c6E
 E6RA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9x0J8DnMoF0JO3vTopD7Ndv4DM3WPviSBIH0Bb+w5IN1jzO2YCH9QIuCQjEFnfbd0q/vk=@dpdk.org
X-Gm-Message-State: AOJu0YyITNy+mzp7mHcfL4qKfIx0DxeZD1JRAfH2S6SfG21AFL3dRdlV
 wL97McC/PE7U9dlQq6JdBZcdUsc3yuIwK4BjxmEB6MbxdKGCEOmrn4AUklfyEMrJUyQ=
X-Gm-Gg: Acq92OHko/f3FiRfaVsVsjgrcaXLm7OjAV9veaspiDkWaV77bhlBGZ0D1d5oBgNrAyz
 sC2IwbITgE9OsQSg25cjzttdIPOKZpvHwEBR8WYL5o4OWR1QrOsthoZxnIy7WsTsV3aVisJkWZI
 Y1uRwglK8Uf2iesWpdsOqxu15/GeeRcscn9r02W0BO2LmQmK5sXrD7Z6ATjpuekTf6O7LSHQNx7
 oVwRPtOpp0KLiFGRhRmtxCwxv2AS3WhH0OlWaNpxKE9QTu+UcKKh6Y8CQgmKaeBw17B6UH11xvc
 v0tCu3u8OTD9K56xupcg0QBVQIVrsmz400EMSq6I3Sfi2ASPHXZFYfGyW5ZIhwh4aZ124muo0Gw
 ZOsvBN2FFqXmME+j9pE1P6+MSrdXh7OAMnVJgHDaAZY/zraxU/BeggjJoBym+aSld03QPv06WLh
 uCz/ZKJJ2vcDgP716KxKJowugUQmk0O86mf4ZXRITyg/Qpl0vSQbO0EoaLKoYvN3HM
X-Received: by 2002:a05:7022:983:b0:130:7246:10aa with SMTP id
 a92af1059eb24-1365f703a38mr6816775c88.12.1779823095808; 
 Tue, 26 May 2026 12:18:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm10312183c88.2.2026.05.26.12.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:18:15 -0700 (PDT)
Date: Tue, 26 May 2026 12:18:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH V2 00/15] power: unify and improve lcore ID verification
Message-ID: <20260526121813.0e15163e@phoenix.local>
In-Reply-To: <a7483ea3-1ad7-4bb5-91d5-fa8539331c98@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260507024230.1198111-1-lihuisong@huawei.com>
 <20260518105954.2309f802@phoenix.local>
 <a7483ea3-1ad7-4bb5-91d5-fa8539331c98@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 19 May 2026 21:09:47 +0800
"lihuisong (C)" <lihuisong@huawei.com> wrote:

> Thanks for giving me this AI review feedback.
> Some of them are still acceptable. will fix it in next version.
> 
> Is this summary from AI generated for each patche series?
> May ask where you obtained this information about AI review?

There is automated review from CI which is done after CI tests runs pass.
But it is using older version of AGENTS.md and missing tool skills support.
I use Claude AI project with current version of AGENTS.md.
It gives the best reviews since it is willing to go look at the existing code.
Other methods just look at the patch itself.
