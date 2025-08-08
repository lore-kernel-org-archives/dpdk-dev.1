Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F710C87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 05:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C0E640270;
	Fri,  8 Aug 2025 07:45:20 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 6C67040150
 for <dev@dpdk.org>; Fri,  8 Aug 2025 07:45:18 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b4239091facso1282586a12.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754631918;
 x=1755236718; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZk/Jv9pI9fHqa1GZORnozKTfXUWkl8jhVPB+zYKWoc=;
 b=UDQt4WjfhMBsj1d/zQp1GPVdXHvkPp3eCBYNTbk1JSqvMt1u481ZDf7G7NVPtWN2qH
 76uRhbkE/DQISyBmN3oCcMx2zOZcfqVn02sBMlL5HBdPqJ/h14lpwX0CEx9oJPL9YSGI
 z5JNZp9+qF/CG/0+6gHtczRrgWpREVL/+vUbdfNZkvs7XV2UBq2wFuqYcykD3wMBYy7M
 IE2G5ltmHKLA3eO8hHTaiG7lvw611mwgU/fdlI62FDDwMVqX+H/j7tpQgM6ysRwUonZA
 qWvDlXingXP4y4Pwqwlin9GMvGEgxfjws2OY2DR5ZQqEMsapqz8mSANinFkV4mHs/xio
 Olzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754631918; x=1755236718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZk/Jv9pI9fHqa1GZORnozKTfXUWkl8jhVPB+zYKWoc=;
 b=Fd1SyTh48hpiYbbs8Buxx4TppGzWd2ATPAvPP4/IgAuGYuQ2CoH7emOO09+D/6zuA0
 OuEXAdzdPe7epkATnw1hWcS/SxP9PEAOssNbbWLQag+Sud0BMg+aQO2ZL2455HZLaQXP
 FqQ6xdmcK8Nk5Q5oPEBFibjVspX94q2zoomQMz977cCAq3tYmAutEW8Jj0JS7r1bR2hC
 l+1SNXzgWiFz8k15LgFOICc+86eRO8tuMAt+ahz19DH2++Zlo6B5sN1yWOxGB3CzK/g6
 Xm74LZAELu5W4xyRAa1LPI3rFJMqzbfq9dFcaaOzG10ujkYk7bF3acq6jsJO3ijQRy9V
 3iLA==
X-Gm-Message-State: AOJu0Yxctb9G3SI9IMxvLOvyexv/WCvJeFQsJw8yU1+k7QyXjLhAcupX
 C5DoJ8xbWathL0ESQ8o0R5fTETjOqEaMjOfR3y0uzU1TMlLfcARa3z4prwakbt93y68=
X-Gm-Gg: ASbGncvCQRY82uQUboj6sB2ViJDdPj7imCXLmPMqNUknX7kvhUf0ZdsipD/qqxGl3PA
 SOp33uUibzK96xrvOLLOyZ06QGc305mT01w4U+9/gJqGrzy+iv7DBrUOwHxuxFEYBnQa94Sy6AF
 kSnDSbsMKZOWS7Y3Rs3Qhq+OLjEq6nNSdsQ6Idmngvg0qPqrRggPYA92KEL/gabTDBGA5fjXi9m
 51VuDxpjvMUNo33M2SBo9rKo3SfI80KoHO00yFdoebZQ8Eb+4hs/mIbw0uSJtZDkKA4b/HnSGRr
 pi8Rb1D9sWmjODrFpd2De58KWRP1Td0DRjxwqwSdeICoa186Xkdj55S1W72Nhn9ajsuYlYaiEd4
 q3GC+6dvrZZvkRO1TnnIkZrRuBlDDvlVgzmqXdWQHGqdcmII/
X-Google-Smtp-Source: AGHT+IG59bxTWzVvUGYtPB6ryeapLSEtxXd9zKgyyaYOZ4XyqVW+P7uSc+Fc2oP6b5WjofDJJu7sog==
X-Received: by 2002:a17:902:da91:b0:234:d292:be7a with SMTP id
 d9443c01a7336-242c1fdca31mr28329915ad.1.1754631917818; 
 Thu, 07 Aug 2025 22:45:17 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f13a31sm198164405ad.64.2025.08.07.22.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 22:45:17 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Vipin.Varghese@amd.com, stephen@networkplumber.org, thomas@monjalon.net,
 Ferruh.Yigit@amd.com, andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org
Subject: RE: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
Date: Fri,  8 Aug 2025 01:44:52 -0400
Message-ID: <20250808054452.1350869-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
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

Hi Vipin Varghese, 
Thank you for your feedback! 

Yes we need graceful exit, directly calling eal_cleanup from secondary was not 
working, we can do the following workaround to use `eal_cleanup`.

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b7affa6da9..5ef6008a3c 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4347,7 +4347,12 @@ monitor_primary(void *arg __rte_unused)
                 * is no longer valid. Calling any cleanup code is going to
                 * run into use after free.
                 */
+               int ret;
                fprintf(stderr, "\nPrimary process is no longer active, exiting...\n");
+               ret = rte_eal_cleanup();
+               if (ret != 0)
+               rte_exit(EXIT_FAILURE,
+                        "EAL cleanup failed: %s\n", strerror(-ret));
                exit(EXIT_FAILURE);
        }
 }
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 52efb8626b..087a4b1137 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -1333,9 +1333,12 @@ rte_eal_cleanup(void)
 #ifdef VFIO_PRESENT
        vfio_mp_sync_cleanup();
 #endif
-       rte_mp_channel_cleanup();
+       if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+               rte_mp_channel_cleanup();
+               rte_eal_alarm_cleanup();
+       }
+
        eal_bus_cleanup();
-       rte_eal_alarm_cleanup();
        rte_trace_save();
        eal_trace_fini();
        eal_mp_dev_hotplug_cleanup();

If Stephen and others are agree, I can supersede this patch with 
the newer ones containing cleanup changes.

Thank you, 
Best Regards,
Khadem 
