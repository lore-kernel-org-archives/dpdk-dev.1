Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14349C83030
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 04:30:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C78D4028B;
	Fri,  4 Jul 2025 06:30:52 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 47F594027D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 06:30:51 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-23633a6ac50so8411175ad.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 21:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751603450; x=1752208250; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MJQiykbaN2zwgMFOC4jWRVlwD/06UZhdM3OodxeHp1E=;
 b=TWENYaUDYRRhfFN3etBw0Mo6WXouBEN7/ccqTWUHMckVGYOjwbPO4LTyXVKmjmRVEF
 l3cBQ1mNAoTLKTOVfrrFRD1mNFXJFvCaGO2BY8kVaSiOoXu70kkORcsp9qmAFKiN3sDI
 9HPUYriD+os00wH4tjRYlSaEFRCHAavVufRpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751603450; x=1752208250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJQiykbaN2zwgMFOC4jWRVlwD/06UZhdM3OodxeHp1E=;
 b=fcxPa66eLMioklX/a16ew5z+qvMxTtUXRwQ9OIHmEgBYOJNxxKrTBwTzZ8gNoyCXFI
 wQt6WY5cYPVZjrfYU08eg7VqAOR13o2jHSNlehvPxNMdoiURky70JDUDgy+MbSQLKtc5
 rz1Rldwe5AJAmN4pb5YzF6bFiU25k4ZgbZtFvOwfps4KtBBwjaTVgowOT6frtr83EZ5W
 GW0TWfl7Fkzwf8FVN+eyptZnHquBW9eVP9r3vzlP5Th+B8PdJLFnl4VruV9q0+YzO+qv
 gtTxUkC0nCI8WBo/rgp3zvGCJyG/h7adZIPhG/I2LiRDQWX51MePUeBbRq2ZmkCEpaeh
 +X+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlR8m2jsZ9jyN5GcSgAD1noT7iV16j/E0W1LDJr7iO/UuCO0guLpXGtekv89f1zhMVx0c=@dpdk.org
X-Gm-Message-State: AOJu0YzN6FEoilfXSyOctXPQcMXMOYzozv2tyktlFD/PtILi9pdBHLIL
 ynjMGahWtwdAT2KJBdQT2sklUHYZ6sgq/9G+7+grMdRWXpiC+TvZdRQ7Nt24JD/9VNmF3RzpSyF
 NdWu+ns7QE4sety4NHtdw+JKSBSzZ5nbnJRnnMZ9v0g==
X-Gm-Gg: ASbGncvyz74tP7bSpuFN5I1GNYdhzi+8eBTf/8E48IWzUz50Iu98F9NOUU1F7zFLVd0
 BOvj3Ocgba7ze/JB6ogS0htOhZFCQKVxNR0Ur/0BYycsf0wOja+KzVk3TQZtc4YOnwKi7n/H3fJ
 kyaaMgYqjQlBO8cT1H6LXjR9fhWL0a4XA32L7Lv8gqvKZPd6XT9YoyDIgzvxQ=
X-Google-Smtp-Source: AGHT+IEEyPx3WWpbIms4McZ5BkUuPZWrNxS6IUkBT0+WIZi/KKzZSUxpN7WIVQzO8wqNzhaVzoYGXVmC8RkM/jO7kqc=
X-Received: by 2002:a17:903:2348:b0:234:8c3d:2912 with SMTP id
 d9443c01a7336-23c8604b0bdmr19676835ad.11.1751603450476; Thu, 03 Jul 2025
 21:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
 <CAJvnSUAO7iBHp9Fm7WiCrCfou3JByrYsL8ZyufcO9VZh-yNM1w@mail.gmail.com>
In-Reply-To: <CAJvnSUAO7iBHp9Fm7WiCrCfou3JByrYsL8ZyufcO9VZh-yNM1w@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 00:25:13 -0400
X-Gm-Features: Ac12FXz11dLRtqFghrkHFVy_j087Ows3aK0BK_MnmTCyyEfJUxz9YEFIlYgM5cU
Message-ID: <CAJvnSUBxJofw934abTkeBX8ConPxUPj=XKSv3u8EuxFBRiZfAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dts: add virtual functions to framework
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007421ca063912f5c4"
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

--0000000000007421ca063912f5c4
Content-Type: text/plain; charset="UTF-8"

And FYI VF results for ConnectX-5 virtual functions for a testrun I just ran

test_suites: ERROR
  vlan: PASS
    test_vlan_header_insertion: PASS
    test_vlan_no_receipt: PASS
    test_vlan_receipt_no_stripping: PASS
    test_vlan_receipt_stripping: PASS
  rte_flow: FAIL
    test_drop_action_ETH: PASS
    test_drop_action_IP: PASS
    test_drop_action_L4: PASS
    test_drop_action_VLAN: PASS
    test_egress_rules: SKIP
      reason: flow rule failed validation.
    test_jump_action: FAIL
      reason: Failed flow creation
    test_modify_actions: FAIL
      reason: Failed flow creation
    test_priority_attribute: PASS
    test_queue_action_ETH: FAIL
      reason: Expected packet was not received on queue 2
    test_queue_action_IP: PASS
    test_queue_action_L4: SKIP
      reason: Required capability '{NicCapability.PHYSICAL_FUNCTION}' not
found.
    test_queue_action_VLAN: PASS
  port_restart_config_persistency: ERROR
    flow_ctrl_port_configuration_persistence: ERROR
      reason: Testpmd failed to set the rx on tx off 0 0 0 0
mac_ctrl_frame_fwd off autoneg off in port 0.
    port_configuration_persistence: PASS

--0000000000007421ca063912f5c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">And FYI VF results for ConnectX-5 virtual functions for a =
testrun I just ran<div><br></div>test_suites: ERROR<br>=C2=A0 vlan: PASS<br=
>=C2=A0 =C2=A0 test_vlan_header_insertion: PASS<br>=C2=A0 =C2=A0 test_vlan_=
no_receipt: PASS<br>=C2=A0 =C2=A0 test_vlan_receipt_no_stripping: PASS<br>=
=C2=A0 =C2=A0 test_vlan_receipt_stripping: PASS<br>=C2=A0 rte_flow: FAIL<br=
>=C2=A0 =C2=A0 test_drop_action_ETH: PASS<br>=C2=A0 =C2=A0 test_drop_action=
_IP: PASS<br>=C2=A0 =C2=A0 test_drop_action_L4: PASS<br>=C2=A0 =C2=A0 test_=
drop_action_VLAN: PASS<br>=C2=A0 =C2=A0 test_egress_rules: SKIP<br>=C2=A0 =
=C2=A0 =C2=A0 reason: flow rule failed validation.<br>=C2=A0 =C2=A0 test_ju=
mp_action: FAIL<br>=C2=A0 =C2=A0 =C2=A0 reason: Failed flow creation<br>=C2=
=A0 =C2=A0 test_modify_actions: FAIL<br>=C2=A0 =C2=A0 =C2=A0 reason: Failed=
 flow creation<br>=C2=A0 =C2=A0 test_priority_attribute: PASS<br>=C2=A0 =C2=
=A0 test_queue_action_ETH: FAIL<br>=C2=A0 =C2=A0 =C2=A0 reason: Expected pa=
cket was not received on queue 2<br>=C2=A0 =C2=A0 test_queue_action_IP: PAS=
S<br>=C2=A0 =C2=A0 test_queue_action_L4: SKIP<br>=C2=A0 =C2=A0 =C2=A0 reaso=
n: Required capability &#39;{NicCapability.PHYSICAL_FUNCTION}&#39; not foun=
d.<br>=C2=A0 =C2=A0 test_queue_action_VLAN: PASS<br>=C2=A0 port_restart_con=
fig_persistency: ERROR<br>=C2=A0 =C2=A0 flow_ctrl_port_configuration_persis=
tence: ERROR<br>=C2=A0 =C2=A0 =C2=A0 reason: Testpmd failed to set the rx o=
n tx off 0 0 0 0 mac_ctrl_frame_fwd off autoneg off in port 0.<br><div>=C2=
=A0 =C2=A0 port_configuration_persistence: PASS=C2=A0</div></div>

--0000000000007421ca063912f5c4--
