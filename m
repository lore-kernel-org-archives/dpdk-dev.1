Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54025C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 07:50:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 699494021E;
	Wed, 16 Jul 2025 09:50:31 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id B72FA4013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 09:50:29 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-23649faf69fso51453725ad.0
 for <dev@dpdk.org>; Wed, 16 Jul 2025 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1752652229;
 x=1753257029; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGPTlYAr4OrMW03FAay0EhwbZBJQ7d+rXSVeTpNymAs=;
 b=ycoDOEnYJMjcNk5p4m+JSnIkbGbXQnwyPW/SqfBjmA248YxGW+8PSuD2pTP8zdNc05
 8tJej9CrnrIWBlKsce+7D/ihtufD8L70cVdiAdLn/jm8tjjoPnl36Y/8IlwxfPqzOCse
 0y4lwRnRf3QMawUOXAQMW8Pf9JgqhicavMlFLuipUe54Phba+AjwUS4AML/7nPd7CUEs
 g26LyI2QQbUCeoIzSARgTEMqrcW9z4A+uLlwQCuOZnwJ4b2Y+O6MDylvlDzhiNkvYAs+
 mG5dxX6CWFnkblkfZfVq2LnuStZnok5ZE3TcrLDQBpMOjnppN2ckcwy6YRZQpMCroVNk
 sBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752652229; x=1753257029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGPTlYAr4OrMW03FAay0EhwbZBJQ7d+rXSVeTpNymAs=;
 b=BLgUybVNqmHJxitXrDI6pExn4CWoYX6K+eqWGQxOIHW9N1fFEjXNojsv58UnBf705U
 6RJfmw8GVnZ14caGQL/w6pRc/tBFuxC24pqDa2FPPzY2P2VsP8YDejUIee9YbN5WTUZ6
 DPVAvLszVUrTKpF8TpFx+ENKKk/NvQY6qqwVKrf6O4c/n7xr4do7HqgnZShb8Qvv7Cd8
 PsY4TatH0f6HXVWpXAvStm9yJzBXLq6TCJ3MnBWTDeXclbygttykAn5XemvYPLJrAop3
 zcIogPgFG8r5MBbC1ovVPHlSblwtNxFBsqENg1VgPef0hids2fc6qTbvuv1YcEN5OekB
 TGHQ==
X-Gm-Message-State: AOJu0YyMQN+JlDnhEG+aI4LBN4xsK2yddgr2Kq5YeFdozITy13xYxIVv
 Qzniyi1lUn4DohwgbKRtQitMK6svNKeu1qlcaUul9Ic8NyrGoVXGXx0xk5HU4GTDLsg=
X-Gm-Gg: ASbGnctsCEmUVjWRvKLtWuwJZJh9fAUXB76L8vstaAvK1e7tNiLd/5hY0UBYvafui85
 hcASdS0cAwobd1fJEOc5ntXvVmy8+L4q4re2usiXbF+stPdDmKInSA9GmF9XYxMCiWs06u6IcxV
 3YFRamM90CuvyYJjsmkbglx/9r2ZpY4A1X2PhJkqQq8vq1qMDZjAOcm3xubqw+uCtBtWe/k45kZ
 wo1fdhjK1CFU0FYiasu4mmR7DtJ0MbmJ/ex0NDb8ERsXWaT25XpurfKvVjKOJURpDyDWe2GTOwI
 NT/ZcDDj66fKnOFi+U6paIM+d/LgBTkarw3tSuO123cglYJbG40rv8ZDsoMvu8jZ/K5ZK3Aff6C
 CUHPU+yJOR5OMHBLjxP5+cne4GszAULrBuY5MqgPSfBiK0gZg
X-Google-Smtp-Source: AGHT+IFBCtqYlP/1dsKFbZ55XThxxvTBx6Wl4gNpONs58o5y7ymXZp/tC4CtD3v+m45b7G23WvqhqQ==
X-Received: by 2002:a17:902:ccce:b0:235:f143:9b07 with SMTP id
 d9443c01a7336-23e25684c62mr29018115ad.5.1752652228789; 
 Wed, 16 Jul 2025 00:50:28 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4322af6sm120618755ad.90.2025.07.16.00.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 00:50:28 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dsosnowski@nvidia.com
Cc: dev@dpdk.org, rasland@nvidia.com, stable@dpdk.org, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH] doc/mlx5: document firmware requirement for flex item
Date: Wed, 16 Jul 2025 03:49:40 -0400
Message-ID: <20250716075013.3539970-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715125249.hwrzd4aasfjhhyxa@ds-vm-debian.local>
References: <20250715125249.hwrzd4aasfjhhyxa@ds-vm-debian.local>
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

Hi Dariusz,

Thanks for the follow-up.

I was using DPDK v23.11 with the following flex item configuration:

{
  "next_header": { "field_mode": "FIELD_MODE_FIXED", "field_size": 0, "field_base": 0 },
  "next_protocol": { "field_mode": "FIELD_MODE_FIXED", "field_size": 8, "field_base": 72 },
  "sample_data": [
    { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 0 },
    { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 32 },
    { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 64 },
    { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 96 }
  ],
  "input_link": [
    { "item": "eth type is 0x08802" }
  ],
  "output_link": [
    { "item": "udp", "next": 17 },
    { "item": "tcp", "next": 6 }
  ]
}

With firmware version 24.30.1004 (MT_0000000704), the following error was produced:

  port-0: flex item #3 creation failed: unsupported header length field mode (FIXED)

After upgrading to firmware version 24.38.1002, the same configuration succeeded.

Example flow after upgrade:

  testpmd> flow flex_item pattern 2 spec 45000000000000000000000001020304 mask FF0000000000000000000000FFFFFFFF
  created pattern #2

  testpmd> flow create 0 ingress pattern eth / ipv4 / udp / flex item is 3 pattern is 2 / end actions mark id 1 / queue index 0 / end
  Flow rule #0 created

It appears this issue was resolved at the firmware level.

Best regards,  
Khadem Ullah

