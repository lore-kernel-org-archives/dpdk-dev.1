Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005D8C87FD2
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 11:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FCEE402AB;
	Fri,  8 Aug 2025 13:49:54 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6EBB24028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 13:49:53 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b4233f86067so1280860a12.0
 for <dev@dpdk.org>; Fri, 08 Aug 2025 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754653792;
 x=1755258592; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkQYIUOtkjQQEN93x27n2Uuyy8XRFN71fA3fW4VJxgI=;
 b=uQ3xptLGdgr1Tu1zGkjUp5AYJ87K9p8qYoZ9zpeJQRri2cvILEvbUBcFsfgUfVynV7
 iAo4XMGum04fEvikt7HOCwMyp/yQaA7cu/bPdPvGYdeLXBbG4nXk7pyLzjJ0JPGOlbtc
 l9a2+zg8dFH55LimoMIPcGRqfrXdVtV8V+hAujXJI+KotAQpEdXuEtKa3+BRgnN1Izfd
 NWExKtY28+3b1GxlOH9MZ82ia3l8Re2pk2j/FWW0qFcms0j5MH0HSI8UlFDgRD3NFUgq
 UMQvepRwxoAQkBF/IZWQ4GDex0mEGpjFIy4921SQG2Y6XmSZ/Cixr0NhX5auSmhTd051
 khVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754653792; x=1755258592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkQYIUOtkjQQEN93x27n2Uuyy8XRFN71fA3fW4VJxgI=;
 b=ahyMnols+NI7ardJC9VrA2RMjqnLecsk0oUBaIzs2yrnmfFP0R/IOLS+hRyrDaPqOq
 moB1zlSh6dAAp31KSHO+Y3mvJn8SRSa/gtkxlSJ8AEUifszRARSPr3m+7EPs4hV97AlX
 zrDBiUYncvS3fGLa0Rba4rW8Llh7iqPad/5M3M1pv46VNF3iR7FgNpxS/Q4ba5kHtJzL
 QGVOsdHjL9JmiJJQST+ZI/3vxMiR40vbOBlRRqV7weDktouypF4JuEZCH0UsosYyWC6o
 /CNAshNQ9FN3qP7zRCg1WhKtpyk2W5M9WsdfSTIH6sVwrTmNzT9JzfEhd6b7uI1iLmSM
 K/PQ==
X-Gm-Message-State: AOJu0YzE1X7gbom25KrlYcvVnBiQg1r6wgBf7AL69MRI+V7AMPBbnKEo
 haz/qW8pLwbPSqL95yO0w+PKMFi42a+BJBnT5AcCcheSFvkzglvAL8J53ukWVg2XWp4=
X-Gm-Gg: ASbGncuel6URhE8EPVllStWNdSuOawROIzPACrfrmfW2YJsveHEk86NDl7r/Idf99d9
 Ol2Ao49pKuRF+Jfzgfq/7d3JnX/T8x9O8MsNQEiBOu3gEt3Nz/a7dADqIXx3M5Jx8wwPGPzllhX
 SgHx9rUCSRhZ54Fj8yp9VlxA3MVDpH9YRf5xwrlfwJzGg5OToOkPpL9Swv9oVMovn5X8vBS+fVZ
 bu+xM+Fk4/Yo6Ua/lDZw83R2bQiWmwqnoIrqo4qM5LWwZCUPs5Ick6+9QBKOO+h0+N8L1vAn+w5
 K5HkPZK2mVEk8HiBesZjgbdCtxZkcwo35BjzoVj+diOQHAfZwe5eWcHjGoXT0P2CTCjDRncQFxe
 6f+DrCa/iRoLOGp2yqfS1bTesZLlmrF4r+GjmHg2JIgveI7ee
X-Google-Smtp-Source: AGHT+IH8BJz5dKDNvZ3Jb1OyKzS2kwO7JcPJL2SK16wP3GzTxDath0iGB/UaDKKdMiiZgi8+Fjhy/g==
X-Received: by 2002:a17:903:41c3:b0:231:9817:6ec1 with SMTP id
 d9443c01a7336-242c2dd23ffmr44368375ad.17.1754653792317; 
 Fri, 08 Aug 2025 04:49:52 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8975c03sm208720605ad.97.2025.08.08.04.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 04:49:51 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Vipin.Varghese@amd.com, stephen@networkplumber.org, thomas@monjalon.net,
 Ferruh.Yigit@amd.com, andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Date: Fri,  8 Aug 2025 07:49:09 -0400
Message-ID: <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
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
Errors-To: dev-bounces@dpdk.org

The crashes are on 22.11, 23.03, 24.11, it is on all dpdk stable versions and 25.07 as well. 
Please first close primary testpmd before secondary testpmd application 
and try to close secondary or execute any of the following commands, 

"show device info all
show port stats all 
show port xstats all 
set fwd rxonly 
set fwd txonly 
start
etc"

We are all agree that these crashes exists. First we were tried 
to prevent the crashes at PMD level, but it was not possible to 
add checks in each PMD. Then we tried to add safety checks 
in ethdev layer, and it was not suitable as with primary closing
all reference to device information (pointers) would lead crashes.

Then we agreed on secondary process monitoring for primary process exiting. 
and it is now resolved on application level, i.e. on testpmd. 

Now, this solution is working perfectly. We can add eal_cleanup for 
gracefull exit. 

Best Regards, 
Khadem 
