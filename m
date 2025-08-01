Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A575DC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 11:29:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4117840662;
	Fri,  1 Aug 2025 13:29:15 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 70A944065A
 for <dev@dpdk.org>; Fri,  1 Aug 2025 13:29:14 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7682560a2f2so2042572b3a.1
 for <dev@dpdk.org>; Fri, 01 Aug 2025 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754047753;
 x=1754652553; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x+OlsvPsEjnc1qd/EbU23z6OxmZwCbloriFSSSZ4uk=;
 b=LfabwP0NQ9mGe/NtV59gJq143Eu9biP0fIf54if07ar76w9fuTB/CHNkH8Ld6Zo3kX
 pFi1uZlwy+jm/8Y9K+VHNiqLL+vZ25wU5LtA5MwQyYiyjY/uPqhpqcSM0zt5JAntuAFU
 wknrzfwro9HeTZqFpB0fP78+h5utai2pncB+JGS9Z/UsrEulxe0AoJm0LGsE7IT6/vhj
 ZIOZ+Jxgw9AREPCrEYQDZWIi3sBvY73BWvN0yxetBaOBJq/WL5JEw7b0/teQlQSqvEzd
 WkRa6y0Qt7d+53lI4SWGJwo24DoTuWH3A0sB7Kc1xPrXont6cO2LNnMaHB1q50pdpVH3
 p0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754047753; x=1754652553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+x+OlsvPsEjnc1qd/EbU23z6OxmZwCbloriFSSSZ4uk=;
 b=js/rvsp8wYnCCS/W7D+K+3OKoCeBdGT0/nc+jj/rGHOfsSFU85iudapoYnX3BCOq3Y
 CJe95FYugag2DROzOAxXR4crXt9K16SZtrNAOkhKvRBnvQdG2hE/zn64Yc5vf4wlHSje
 XtQfDNhkSNF5UOuv4rGt+QLFkW9CdYqg6gYlvS9JT8SbAx4+JhugESagVe/23WaDxOZx
 yCWdnYQX7G3X80vvjAxWm5EfeEHggcZIxgxcJMhsDZpiK6pzfbyHfpgPdcwMnCmX18iD
 KqNTBgMZ1VKd4pLschB5Tab5S1hKkmNppbw7vVtv1xmBU8CGnQP4BNPGMsYEO4qgvhYd
 Ag5Q==
X-Gm-Message-State: AOJu0Ywtgqack2CQwRAB9+SawqvPaEyZmF/yzBCeo2cWq6mYrPTCiNnj
 WuY/uuYI43udlzTdc9hmHa5OPf0uu7zWL3to84Mw8uSVtwbnEUSf13kaNTSNxFPcf14W719MoCs
 zAIQHi/g=
X-Gm-Gg: ASbGncvm/AxKpllhvxrnlvgebgt4pDbgnRBtNRy/RAeg+m5v4KipzvENwKcdoIywDcK
 1EXqmvZ1EhYRw1oH/u4oFQY9iOwYQ/d3wqdqerqhWTtM5jqkHQCrGTg/8TuO4uucXU5tr+akPU7
 uqElPNQ59OtYm2T17AnEl39bSAQv3mqCJq2pi81+Q4OyJwbKSg1yFTFvF6Nv1S+tMqhvDmEQ2wj
 64P72DiNeDAmZFSn9tx6JqtkOzjeRDbeNOsV/IstrgB5kDIu3Hv2ZCNkDg2rcSAwt/1paI0Iaq3
 k1X3MfKJFktkKJzWOKryCEZOdVoYsEUJxbGLRVjKHTRkF+VPNv/UQfrY7w0mLvXXFXr6EEihpAd
 i8raE3Sj4Viuip0BPkgVTK1c64yh7UUA08emQaP70ebXHirJH
X-Google-Smtp-Source: AGHT+IGJXDXRE+3E1l+KntO+odGpEu9t4UwH/HUAMy3IHqq2jx1vkLUAXM5MgJHXJxiDeqfhITqesg==
X-Received: by 2002:a05:6a00:4215:b0:76b:c68e:1001 with SMTP id
 d2e1a72fcca58-76bcd00b52emr9948443b3a.5.1754047753430; 
 Fri, 01 Aug 2025 04:29:13 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8f48fsm3898547b3a.40.2025.08.01.04.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 04:29:12 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org, andrew.rybchenko@oktetlabs.ru, jasvinder.singh@intel.com,
 bruce.richardson@intel.com
Cc: thomas@monjalon.net,
	ivan.malov@arknetworks.am,
	stable@dpdk.org
Subject: Re: [PATCH] net/rte_net: fix inner L2 length for tunneled Ethernet
 packets
Date: Fri,  1 Aug 2025 07:28:34 -0400
Message-ID: <20250801112834.60310-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
References: <5a75dd27-a19b-4dad-b3bd-cc7f31e4619d@oktetlabs.ru>
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

Hi Andrew, 

Thanks for your feedback.

Please check mbuf packet types and the following test case:
https://doc.dpdk.org/dts-20.02/test_plans/uni_pkt_test_plan.html#test-case-vxlan-tunnel-packet-type-detect
sendp([Ether()/IP()/UDP()/Vxlan()/Ether()/IP(frag=5)/Raw('\0'*40)],
iface=txItf)

(outer) L2 type: ETHER
(outer) L3 type: IPV4_EXT_UNKNOWN
(outer) L4 type: Unknown
Tunnel type: GRENAT
Inner L2 type: ETHER
Inner L3 type: IPV4_EXT_UNKNOWN
Inner L4 type: L4_FRAG


union {
        uint32_t packet_type; /**< L2/L3/L4 and tunnel information. */
        __extension__
        struct {
          uint8_t l2_type:4;   /**< (Outer) L2 type. */
          uint8_t l3_type:4;   /**< (Outer) L3 type. */
          uint8_t l4_type:4;   /**< (Outer) L4 type. */
          uint8_t tun_type:4;  /**< Tunnel type. */
          union {
            uint8_t inner_esp_next_proto;
            /**< ESP next protocol type, valid if
             * RTE_PTYPE_TUNNEL_ESP tunnel type is set
             * on both Tx and Rx.
             */
            __extension__
            struct {
              uint8_t inner_l2_type:4;
              /**< Inner L2 type. */
              uint8_t inner_l3_type:4;
              /**< Inner L3 type. */
            };
          };
          uint8_t inner_l4_type:4; /**< Inner L4 type. */
        };
      };


Based on the above, it seems that inner_l2_len have to the length of Ether. 
Ther might need to be some correspondent between both fields to potray the same information. 
Or, the inner_l2_type and inner_l2_len are completly different ? 

Best Regards, 
Khadem
