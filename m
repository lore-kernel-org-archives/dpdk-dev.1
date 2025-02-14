Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC6C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 23:38:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 633D54028A;
	Sat, 15 Feb 2025 00:38:43 +0100 (CET)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by mails.dpdk.org (Postfix) with ESMTP id AB65E40281
 for <dev@dpdk.org>; Sat, 15 Feb 2025 00:38:40 +0100 (CET)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5209ea469e9so121127e0c.0
 for <dev@dpdk.org>; Fri, 14 Feb 2025 15:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739576320;
 x=1740181120; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QGkwQUK1iKWzQbHUWOPA3QN2aiR96C//WKVGET/oUgM=;
 b=oJm/wMwrMmPWGOL87b1DCnZqbXjA0IpLbts5xaVRTZlma3IC/TxVIAYvHbt56z5BmZ
 PQZFEjV7aytMc4eFf0smGQgq+RVLQmGPJGRhXEbSg2vCenneQopI/43dZlitzNx27FcV
 HkVD4TxTrBfihPAMJAWkeJfY7Jg4iv1wa5gUg60bC67lU5u38jKM93kY8rPaMrYiDCcY
 ICKsDtCmM9RhaD/PzG6FQ2Gz8uCfO4hiYpSG12nF8n5sGCZfRI1MTRGJtZisgPBIKhHx
 3J3MIBsLSvhYuuUf4ryk0lQJ8XnWL2iFpPrAOwi57lPYLYnS1qXa6bl+A8XOertJsnbH
 S/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739576320; x=1740181120;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QGkwQUK1iKWzQbHUWOPA3QN2aiR96C//WKVGET/oUgM=;
 b=EaKAL45r/5VqrRcEisRg3rrYso4c2goMVjHaCz8qzkTMh6ka4GoVFn0n+eDvtutpcu
 8ukXZh1+TnUxV5pSFVQTcyI/rBRgzLr70wOqqblv13cOefjk/rQ+HnA9ccMnR/TRjFmo
 CFjtHpSJBU6B2yKFz1FxqqmcIjf/OOIX5n6gRmXfIY3LwdYIglpQbJhsTIpFTSdtEQID
 2Qi/MQadR0WcLZNC11z0/VAIWv7r1XCRvIAe7TF8O/WHRPjYViOTav94yl1Uu1Aazs+7
 LzCh5j+NMOJTV5ebwa0/9fzlZutb3t8SoUeIIkqvoYw37l9yNHcpJaEgriF6Vh0dgqjy
 g25g==
X-Gm-Message-State: AOJu0Yzw3/ymDQ/70gTvnFJfqzs8imk2uqH5dWBsPzFGVKKf9XpvFEQX
 98A8uxe94caklumnRS3WIbZanOD4HYl84ZyCN4pJ/vDu3/IJDsb/bswE35iWZndjTLbp1/7mfEC
 0zCcwbhB5Teax0S3Vn08rwiaaD4BlwhSFjrLVXmP4iDbs9en4FHXbxw==
X-Gm-Gg: ASbGncuz+M+gZjNKiIAgkIKepLaFzp7QhMKFpJDNBZJZdkZZMsJkLscwTIvi18uMK1r
 IbxqqZKD9iph+yXSUmmI8vNIa+Al62pcbB7xolw1E9l4XQR0xNqwAhA/GJIoMaxsVc8JSPZfRJw
 ==
X-Google-Smtp-Source: AGHT+IHET7MmV7AK9EhtiV0bpCGnZqmxbg6uHgaicQEJK0ZHHPxAYv/aqXxub9GQB14GGzkXGFtqDpbT+/TTomjrquI=
X-Received: by 2002:a05:6122:2005:b0:520:4806:a422 with SMTP id
 71dfb90a1353d-5209dc293cdmr731934e0c.3.1739576319592; Fri, 14 Feb 2025
 15:38:39 -0800 (PST)
MIME-Version: 1.0
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 14 Feb 2025 15:38:28 -0800
X-Gm-Features: AWEUYZmKG6rCFsIUgWSKCmKrfC1w4fGwV5FOpdAc96BJeAfuYz3Dcn29TSwXW30
Message-ID: <CAOaVG17OTXYS2K1KojcbeC4hzM9Av1MKhSk1N9rzMbtX6qL0xg@mail.gmail.com>
Subject: PVS studio warnings in zxdh
To: Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000096e99f062e22acb5"
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

--00000000000096e99f062e22acb5
Content-Type: text/plain; charset="UTF-8"

Now that zxdh is main branch, ran the PVS studio analyzer over it and
reported many new warnings.


MESSAGES
LocationCodeMessage
Fails/Info

zxdh_common.c (223)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer
'recv_buf' is cast to a more strictly aligned pointer type.

zxdh_ethdev.c (816)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
813, 816.

zxdh_ethdev.c (866)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: rxmode->mq_mode != RTE_ETH_MQ_RX_NONE.

zxdh_ethdev.c (709)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'hdr_mz'.

zxdh_ethdev.c (724)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'txvq'.

zxdh_ethdev.c (651)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_ethdev.c (651)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_ethdev.c (1322)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_ethdev.c (107)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

zxdh_ethdev.c (1188)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

zxdh_ethdev.c (1452)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

zxdh_ethdev_ops.c (723)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
721, 723.

zxdh_ethdev_ops.c (744)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
742, 744.

zxdh_ethdev_ops.c (769)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
767, 769.

zxdh_ethdev_ops.c (791)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
789, 791.

zxdh_ethdev_ops.c (818)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
816, 818.

zxdh_ethdev_ops.c (840)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
838, 840.

zxdh_ethdev_ops.c (1072)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
1070, 1072.

zxdh_ethdev_ops.c (1090)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
1088, 1090.

zxdh_ethdev_ops.c (1186)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
1184, 1186.

zxdh_ethdev_ops.c (1212)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
1210, 1212.

zxdh_ethdev_ops.c (357)
V526 <https://pvs-studio.com/en/docs/warnings/v526/> The 'memcmp' function
returns 0 if corresponding buffers are equal. Consider examining the
condition for mistakes.

zxdh_ethdev_ops.c (1283)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

zxdh_ethdev_ops.c (1485)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

zxdh_ethdev_ops.c (1537)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

zxdh_ethdev_ops.c (329)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The
'mac_filter->filter_flag' variable was assigned the same value.

zxdh_msg.c (203)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'lock_id >=
(511)' is always false.

zxdh_msg.c (463)
V557 <https://pvs-studio.com/en/docs/warnings/v557/> Array overrun is
possible. The value of 'dst_index' index could reach 255.

zxdh_msg.c (463)
V557 <https://pvs-studio.com/en/docs/warnings/v557/> Array overrun is
possible. The value of 'src_index' index could reach 255.

zxdh_msg.c (464)
V557 <https://pvs-studio.com/en/docs/warnings/v557/> Array overrun is
possible. The value of 'dst_index' index could reach 255.

zxdh_msg.c (464)
V557 <https://pvs-studio.com/en/docs/warnings/v557/> Array overrun is
possible. The value of 'src_index' index could reach 255.

zxdh_msg.c (579)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer
'msg_header' is cast to a more strictly aligned pointer type.

zxdh_msg.c (592)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer
'msg_header' is cast to a more strictly aligned pointer type.

zxdh_msg.c (664)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer
'tmp_msg_header' is cast to a more strictly aligned pointer type.

zxdh_msg.c (397)
V1037 <https://pvs-studio.com/en/docs/warnings/v1037/> Two or more
case-branches perform the same actions. Check lines: 397, 400

zxdh_msg.c (394)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items '2', '1', '1', '0' in lines 394,
397, 400, 403.

zxdh_np.c (1068)
V614 <https://pvs-studio.com/en/docs/warnings/v614/> Potentially
uninitialized variable 'temp_idx' used.

zxdh_np.c (1524)
V785 <https://pvs-studio.com/en/docs/warnings/v785/> Constant expression in
switch statement.

zxdh_np.c (1925)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer
'form_buff' is cast to a more strictly aligned pointer type.

zxdh_np.c (224)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (285)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (385)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (388)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (392)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (397)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (588)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (588)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

zxdh_np.c (588)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (604)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (714)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (714)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

zxdh_np.c (714)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (778)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (783)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (806)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (838)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (909)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

zxdh_np.c (949)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1158)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1166)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1317)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1326)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1326)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1438)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1623)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1672)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1738)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1761)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1766)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1812)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1812)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1832)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1877)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1911)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (2010)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (2040)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_np.c (1353)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The 'rc' variable
was assigned the same value.

zxdh_np.c (1365)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The 'rc' variable
was assigned the same value.

zxdh_np.c (2049)
V1051 <https://pvs-studio.com/en/docs/warnings/v1051/> Consider checking
for misprints. It's possible that the 'ppu_eram_baddr' should be checked
here.

zxdh_pci.c (181)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'notify_off'
variable is assigned values twice successively. Perhaps this is a mistake.
Check lines: 180, 181.

zxdh_pci.c (422)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_queue.c (187)
V763 <https://pvs-studio.com/en/docs/warnings/v763/> Parameter 'nb_desc' is
always rewritten in function body before being used.

zxdh_queue.c (230)
V763 <https://pvs-studio.com/en/docs/warnings/v763/> Parameter 'nb_desc' is
always rewritten in function body before being used.

zxdh_queue.c (118)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'queue_type
== ZXDH_VTNET_TQ' is always true.

zxdh_queue.c (243)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

zxdh_queue.h (305)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The
'vq->vq_packed.event_flags_shadow' variable was assigned the same value.

zxdh_tables.c (350)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'ret' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
341, 350.

zxdh_tables.c (58)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'!hw->is_pf' is always false.

zxdh_tables.c (64)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'!port_attr.rss_enable' is always true.

zxdh_tables.c (34)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer
'port_attr' is cast to a more strictly aligned pointer type.

zxdh_tables.c (98)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer '&
port_attr' is cast to a more strictly aligned pointer type.

zxdh_tables.c (200)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer
'port_attr' is cast to a more strictly aligned pointer type.

zxdh_tables.c (741)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer '&
rss_vqid' is cast to a more strictly aligned pointer type.

zxdh_tables.c (765)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer '&
rss_vqid' is cast to a more strictly aligned pointer type.

zxdh_tables.c (146)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

zxdh_tables.c (289)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_tables.c (324)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

zxdh_tables.c (353)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

--00000000000096e99f062e22acb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-family:arial,sans-serif;font-size:small">Now that zxdh i=
s main branch, ran the PVS studio analyzer over it and reported many new wa=
rnings.</div><div class=3D"gmail_default" style=3D"font-family:arial,sans-s=
erif;font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-=
family:arial,sans-serif;font-size:small"><div class=3D"gmail_default"><br><=
/div><div><table style=3D"color:rgb(0,0,0);font-variant-numeric:normal;font=
-variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:=
none;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fon=
t-size:12pt;line-height:normal;font-family:&quot;normal Century Gothic&quot=
;;width:2250px"><caption style=3D"font-weight:bold;background-image:initial=
;background-position:initial;background-size:initial;background-repeat:init=
ial;background-origin:initial;background-clip:initial;border:none">MESSAGES=
</caption><tbody><tr style=3D"background:black;color:white"><th style=3D"wi=
dth:670.594px">Location</th><th style=3D"width:110.094px">Code</th><th styl=
e=3D"width:1455.31px">Message</th></tr><tr style=3D"background:lightcyan"><=
td colspan=3D"5" style=3D"padding:0px;text-align:center;vertical-align:top;=
color:red;font-size:1.2em">Fails/Info</td></tr><tr><td style=3D"padding:0px=
;vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/ma=
in/drivers/net/zxdh/zxdh_common.c">zxdh_common.c (223)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td sty=
le=3D"padding:0px;vertical-align:top;width:1457.31px">The pointer &#39;recv=
_buf&#39; is cast to a more strictly aligned pointer type.</td></tr><tr><td=
 style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/ho=
me/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev.c">zxdh_ethdev.c (816)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V5=
19</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">The=
 &#39;ret&#39; variable is assigned values twice successively. Perhaps this=
 is a mistake. Check lines: 813, 816.</td></tr><tr><td style=3D"padding:0px=
;vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/ma=
in/drivers/net/zxdh/zxdh_ethdev.c">zxdh_ethdev.c (866)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v560/">V560</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1457.31px">A part of conditional e=
xpression is always false: rxmode-&gt;mq_mode !=3D RTE_ETH_MQ_RX_NONE.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div =
title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev.c">zxdh_et=
hdev.c (709)</div></td><td style=3D"padding:0px;vertical-align:top;width:11=
2.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnin=
gs/v522/">V522</a></td><td style=3D"padding:0px;vertical-align:top;width:14=
57.31px">There might be dereferencing of a potential null pointer &#39;hdr_=
mz&#39;.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672=
.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethd=
ev.c">zxdh_ethdev.c (724)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/e=
n/docs/warnings/v522/">V522</a></td><td style=3D"padding:0px;vertical-align=
:top;width:1457.31px">There might be dereferencing of a potential null poin=
ter &#39;txvq&#39;.</td></tr><tr><td style=3D"padding:0px;vertical-align:to=
p;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxd=
h/zxdh_ethdev.c">zxdh_ethdev.c (651)</div></td><td style=3D"padding:0px;ver=
tical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1457.31px">Incorrect format. Consider checking the fi=
fth actual argument of the &#39;rte_log&#39; function. The SIGNED integer t=
ype argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-al=
ign:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/n=
et/zxdh/zxdh_ethdev.c">zxdh_ethdev.c (651)</div></td><td style=3D"padding:0=
px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https:/=
/pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0=
px;vertical-align:top;width:1457.31px">Incorrect format. Consider checking =
the sixth actual argument of the &#39;rte_log&#39; function. The SIGNED int=
eger type argument is expected.</td></tr><tr><td style=3D"padding:0px;verti=
cal-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/dri=
vers/net/zxdh/zxdh_ethdev.c">zxdh_ethdev.c (1322)</div></td><td style=3D"pa=
dding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"=
https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"pa=
dding:0px;vertical-align:top;width:1457.31px">Incorrect format. Consider ch=
ecking the sixth actual argument of the &#39;rte_log&#39; function. The SIG=
NED integer type argument is expected.</td></tr><tr><td style=3D"padding:0p=
x;vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/m=
ain/drivers/net/zxdh/zxdh_ethdev.c">zxdh_ethdev.c (107)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v1027/">V1027</a></td><td sty=
le=3D"padding:0px;vertical-align:top;width:1457.31px">Pointer to an object =
of the &#39;rte_device&#39; class is cast to unrelated &#39;rte_pci_device&=
#39; class.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:=
672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_e=
thdev.c">zxdh_ethdev.c (1188)</div></td><td style=3D"padding:0px;vertical-a=
lign:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.c=
om/en/docs/warnings/v1027/">V1027</a></td><td style=3D"padding:0px;vertical=
-align:top;width:1457.31px">Pointer to an object of the &#39;rte_device&#39=
; class is cast to unrelated &#39;rte_pci_device&#39; class.</td></tr><tr><=
td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/=
home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev.c">zxdh_ethdev.c (14=
52)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px">=
<a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1027/=
">V1027</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px=
">Pointer to an object of the &#39;rte_device&#39; class is cast to unrelat=
ed &#39;rte_pci_device&#39; class.</td></tr><tr><td style=3D"padding:0px;ve=
rtical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/=
drivers/net/zxdh/zxdh_ethdev_ops.c">zxdh_ethdev_ops.c (723)</div></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V519</a></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:1457.31px">The &#39;ret&#39; v=
ariable is assigned values twice successively. Perhaps this is a mistake. C=
heck lines: 721, 723.</td></tr><tr><td style=3D"padding:0px;vertical-align:=
top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/z=
xdh/zxdh_ethdev_ops.c">zxdh_ethdev_ops.c (744)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"htt=
ps://pvs-studio.com/en/docs/warnings/v519/">V519</a></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:1457.31px">The &#39;ret&#39; variable is as=
signed values twice successively. Perhaps this is a mistake. Check lines: 7=
42, 744.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672=
.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethd=
ev_ops.c">zxdh_ethdev_ops.c (769)</div></td><td style=3D"padding:0px;vertic=
al-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-stud=
io.com/en/docs/warnings/v519/">V519</a></td><td style=3D"padding:0px;vertic=
al-align:top;width:1457.31px">The &#39;ret&#39; variable is assigned values=
 twice successively. Perhaps this is a mistake. Check lines: 767, 769.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div =
title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev_ops.c">zxd=
h_ethdev_ops.c (791)</div></td><td style=3D"padding:0px;vertical-align:top;=
width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/doc=
s/warnings/v519/">V519</a></td><td style=3D"padding:0px;vertical-align:top;=
width:1457.31px">The &#39;ret&#39; variable is assigned values twice succes=
sively. Perhaps this is a mistake. Check lines: 789, 791.</td></tr><tr><td =
style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/hom=
e/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev_ops.c">zxdh_ethdev_ops.=
c (818)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094=
px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v5=
19/">V519</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31=
px">The &#39;ret&#39; variable is assigned values twice successively. Perha=
ps this is a mistake. Check lines: 816, 818.</td></tr><tr><td style=3D"padd=
ing:0px;vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/=
DPDK/main/drivers/net/zxdh/zxdh_ethdev_ops.c">zxdh_ethdev_ops.c (840)</div>=
</td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V519</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">The &#39;=
ret&#39; variable is assigned values twice successively. Perhaps this is a =
mistake. Check lines: 838, 840.</td></tr><tr><td style=3D"padding:0px;verti=
cal-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/dri=
vers/net/zxdh/zxdh_ethdev_ops.c">zxdh_ethdev_ops.c (1072)</div></td><td sty=
le=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" =
href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V519</a></td><td sty=
le=3D"padding:0px;vertical-align:top;width:1457.31px">The &#39;ret&#39; var=
iable is assigned values twice successively. Perhaps this is a mistake. Che=
ck lines: 1070, 1072.</td></tr><tr><td style=3D"padding:0px;vertical-align:=
top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/z=
xdh/zxdh_ethdev_ops.c">zxdh_ethdev_ops.c (1090)</div></td><td style=3D"padd=
ing:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"ht=
tps://pvs-studio.com/en/docs/warnings/v519/">V519</a></td><td style=3D"padd=
ing:0px;vertical-align:top;width:1457.31px">The &#39;ret&#39; variable is a=
ssigned values twice successively. Perhaps this is a mistake. Check lines: =
1088, 1090.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:=
672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_e=
thdev_ops.c">zxdh_ethdev_ops.c (1186)</div></td><td style=3D"padding:0px;ve=
rtical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v519/">V519</a></td><td style=3D"padding:0px;ve=
rtical-align:top;width:1457.31px">The &#39;ret&#39; variable is assigned va=
lues twice successively. Perhaps this is a mistake. Check lines: 1184, 1186=
.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"=
><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev_ops.=
c">zxdh_ethdev_ops.c (1212)</div></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com=
/en/docs/warnings/v519/">V519</a></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:1457.31px">The &#39;ret&#39; variable is assigned values twice=
 successively. Perhaps this is a mistake. Check lines: 1210, 1212.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div titl=
e=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev_ops.c">zxdh_et=
hdev_ops.c (357)</div></td><td style=3D"padding:0px;vertical-align:top;widt=
h:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/wa=
rnings/v526/">V526</a></td><td style=3D"padding:0px;vertical-align:top;widt=
h:1457.31px">The &#39;memcmp&#39; function returns 0 if corresponding buffe=
rs are equal. Consider examining the condition for mistakes.</td></tr><tr><=
td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/=
home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev_ops.c">zxdh_ethdev_o=
ps.c (1283)</div></td><td style=3D"padding:0px;vertical-align:top;width:112=
.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warning=
s/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:145=
7.31px">Incorrect format. Consider checking the fifth actual argument of th=
e &#39;rte_log&#39; function. The UNSIGNED integer type argument is expecte=
d.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px=
"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_ethdev_ops=
.c">zxdh_ethdev_ops.c (1485)</div></td><td style=3D"padding:0px;vertical-al=
ign:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.co=
m/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-al=
ign:top;width:1457.31px">Incorrect format. Consider checking the fifth actu=
al argument of the &#39;rte_log&#39; function. The UNSIGNED integer type ar=
gument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:to=
p;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxd=
h/zxdh_ethdev_ops.c">zxdh_ethdev_ops.c (1537)</div></td><td style=3D"paddin=
g:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"http=
s://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"paddin=
g:0px;vertical-align:top;width:1457.31px">Incorrect format. Consider checki=
ng the fifth actual argument of the &#39;rte_log&#39; function. The UNSIGNE=
D integer type argument is expected.</td></tr><tr><td style=3D"padding:0px;=
vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/mai=
n/drivers/net/zxdh/zxdh_ethdev_ops.c">zxdh_ethdev_ops.c (329)</div></td><td=
 style=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_bla=
nk" href=3D"https://pvs-studio.com/en/docs/warnings/v1048/">V1048</a></td><=
td style=3D"padding:0px;vertical-align:top;width:1457.31px">The &#39;mac_fi=
lter-&gt;filter_flag&#39; variable was assigned the same value.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_msg.c">zxdh_msg.c (203=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a=
 target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V=
547</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Ex=
pression &#39;lock_id &gt;=3D (511)&#39; is always false.</td></tr><tr><td =
style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/hom=
e/shemminger/DPDK/main/drivers/net/zxdh/zxdh_msg.c">zxdh_msg.c (463)</div><=
/td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v557/">V557</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Array ove=
rrun is possible. The value of &#39;dst_index&#39; index could reach 255.</=
td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><d=
iv title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_msg.c">zxdh_ms=
g.c (463)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.0=
94px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/=
v557/">V557</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.=
31px">Array overrun is possible. The value of &#39;src_index&#39; index cou=
ld reach 255.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;widt=
h:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh=
_msg.c">zxdh_msg.c (464)</div></td><td style=3D"padding:0px;vertical-align:=
top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en=
/docs/warnings/v557/">V557</a></td><td style=3D"padding:0px;vertical-align:=
top;width:1457.31px">Array overrun is possible. The value of &#39;dst_index=
&#39; index could reach 255.</td></tr><tr><td style=3D"padding:0px;vertical=
-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/driver=
s/net/zxdh/zxdh_msg.c">zxdh_msg.c (464)</div></td><td style=3D"padding:0px;=
vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pv=
s-studio.com/en/docs/warnings/v557/">V557</a></td><td style=3D"padding:0px;=
vertical-align:top;width:1457.31px">Array overrun is possible. The value of=
 &#39;src_index&#39; index could reach 255.</td></tr><tr><td style=3D"paddi=
ng:0px;vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/D=
PDK/main/drivers/net/zxdh/zxdh_msg.c">zxdh_msg.c (579)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td sty=
le=3D"padding:0px;vertical-align:top;width:1457.31px">The pointer &#39;msg_=
header&#39; is cast to a more strictly aligned pointer type.</td></tr><tr><=
td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/=
home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_msg.c">zxdh_msg.c (592)</di=
v></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a targ=
et=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032=
</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">The p=
ointer &#39;msg_header&#39; is cast to a more strictly aligned pointer type=
.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"=
><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_msg.c">zxdh=
_msg.c (664)</div></td><td style=3D"padding:0px;vertical-align:top;width:11=
2.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnin=
gs/v1032/">V1032</a></td><td style=3D"padding:0px;vertical-align:top;width:=
1457.31px">The pointer &#39;tmp_msg_header&#39; is cast to a more strictly =
aligned pointer type.</td></tr><tr><td style=3D"padding:0px;vertical-align:=
top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/z=
xdh/zxdh_msg.c">zxdh_msg.c (397)</div></td><td style=3D"padding:0px;vertica=
l-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studi=
o.com/en/docs/warnings/v1037/">V1037</a></td><td style=3D"padding:0px;verti=
cal-align:top;width:1457.31px">Two or more case-branches perform the same a=
ctions. Check lines: 397, 400</td></tr><tr><td style=3D"padding:0px;vertica=
l-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drive=
rs/net/zxdh/zxdh_msg.c">zxdh_msg.c (394)</div></td><td style=3D"padding:0px=
;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://p=
vs-studio.com/en/docs/warnings/v525/">V525</a></td><td style=3D"padding:0px=
;vertical-align:top;width:1457.31px">The code contains the collection of si=
milar blocks. Check items &#39;2&#39;, &#39;1&#39;, &#39;1&#39;, &#39;0&#39=
; in lines 394, 397, 400, 403.</td></tr><tr><td style=3D"padding:0px;vertic=
al-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/driv=
ers/net/zxdh/zxdh_np.c">zxdh_np.c (1068)</div></td><td style=3D"padding:0px=
;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://p=
vs-studio.com/en/docs/warnings/v614/">V614</a></td><td style=3D"padding:0px=
;vertical-align:top;width:1457.31px">Potentially uninitialized variable &#3=
9;temp_idx&#39; used.</td></tr><tr><td style=3D"padding:0px;vertical-align:=
top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/z=
xdh/zxdh_np.c">zxdh_np.c (1524)</div></td><td style=3D"padding:0px;vertical=
-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio=
.com/en/docs/warnings/v785/">V785</a></td><td style=3D"padding:0px;vertical=
-align:top;width:1457.31px">Constant expression in switch statement.</td></=
tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div ti=
tle=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (19=
25)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px">=
<a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1032/=
">V1032</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px=
">The pointer &#39;form_buff&#39; is cast to a more strictly aligned pointe=
r type.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.=
594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c"=
>zxdh_np.c (224)</div></td><td style=3D"padding:0px;vertical-align:top;widt=
h:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/wa=
rnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;widt=
h:1457.31px">Incorrect format. Consider checking the fifth actual argument =
of the &#39;rte_log&#39; function. The SIGNED integer type argument is expe=
cted.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.59=
4px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">z=
xdh_np.c (285)</div></td><td style=3D"padding:0px;vertical-align:top;width:=
112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warn=
ings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:=
1457.31px">Incorrect format. Consider checking the sixth actual argument of=
 the &#39;rte_log&#39; function. The SIGNED integer type argument is expect=
ed.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594p=
x"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxd=
h_np.c (385)</div></td><td style=3D"padding:0px;vertical-align:top;width:11=
2.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnin=
gs/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:14=
57.31px">Incorrect format. Consider checking the fifth actual argument of t=
he &#39;rte_log&#39; function. The SIGNED integer type argument is expected=
.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"=
><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_=
np.c (388)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.=
094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings=
/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1457=
.31px">Incorrect format. Consider checking the fifth actual argument of the=
 &#39;rte_log&#39; function. The SIGNED integer type argument is expected.<=
/td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><=
div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np=
.c (392)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.09=
4px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v=
576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.3=
1px">Incorrect format. Consider checking the fifth actual argument of the &=
#39;rte_log&#39; function. The SIGNED integer type argument is expected.</t=
d></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><di=
v title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c=
 (397)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v57=
6/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31p=
x">Incorrect format. Consider checking the fifth actual argument of the &#3=
9;rte_log&#39; function. The SIGNED integer type argument is expected.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div =
title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (=
588)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"=
><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/=
">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px"=
>Incorrect format. Consider checking the fifth actual argument of the &#39;=
rte_log&#39; function. The SIGNED integer type argument is expected.</td></=
tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div ti=
tle=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (58=
8)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><=
a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">=
V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">I=
ncorrect format. Consider checking the seventh actual argument of the &#39;=
rte_log&#39; function. The SIGNED integer type argument is expected.</td></=
tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div ti=
tle=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (58=
8)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><=
a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">=
V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">I=
ncorrect format. Consider checking the sixth actual argument of the &#39;rt=
e_log&#39; function. The SIGNED integer type argument is expected.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div titl=
e=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (604)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (714)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (714)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the seventh actual argument of the &#39;rte=
_log&#39; function. The SIGNED integer type argument is expected.</td></tr>=
<tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (714)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the sixth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (778)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (783)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (806)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (838)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (909)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the seventh actual argument of the &#39;rte=
_log&#39; function. The SIGNED integer type argument is expected.</td></tr>=
<tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (949)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1158)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1166)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1317)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1326)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1326)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the sixth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1438)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1623)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1672)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1738)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1761)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1766)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1812)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1812)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the sixth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1832)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1877)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1911)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (2010)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (2040)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">Inc=
orrect format. Consider checking the fifth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1353)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1048/">V=
1048</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">T=
he &#39;rc&#39; variable was assigned the same value.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/home/sh=
emminger/DPDK/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (1365)</div></td><=
td style=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_b=
lank" href=3D"https://pvs-studio.com/en/docs/warnings/v1048/">V1048</a></td=
><td style=3D"padding:0px;vertical-align:top;width:1457.31px">The &#39;rc&#=
39; variable was assigned the same value.</td></tr><tr><td style=3D"padding=
:0px;vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPD=
K/main/drivers/net/zxdh/zxdh_np.c">zxdh_np.c (2049)</div></td><td style=3D"=
padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v1051/">V1051</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1457.31px">Consider checking for m=
isprints. It&#39;s possible that the &#39;ppu_eram_baddr&#39; should be che=
cked here.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:6=
72.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_pc=
i.c">zxdh_pci.c (181)</div></td><td style=3D"padding:0px;vertical-align:top=
;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/do=
cs/warnings/v519/">V519</a></td><td style=3D"padding:0px;vertical-align:top=
;width:1457.31px">The &#39;notify_off&#39; variable is assigned values twic=
e successively. Perhaps this is a mistake. Check lines: 180, 181.</td></tr>=
<tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_pci.c">zxdh_pci.c (422=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a=
 target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V=
576</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">In=
correct format. Consider checking the fifth actual argument of the &#39;rte=
_log&#39; function. The SIGNED integer type argument is expected.</td></tr>=
<tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=
=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_queue.c">zxdh_queue.c =
(187)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px=
"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v763=
/">V763</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px=
">Parameter &#39;nb_desc&#39; is always rewritten in function body before b=
eing used.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:6=
72.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_qu=
eue.c">zxdh_queue.c (230)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/e=
n/docs/warnings/v763/">V763</a></td><td style=3D"padding:0px;vertical-align=
:top;width:1457.31px">Parameter &#39;nb_desc&#39; is always rewritten in fu=
nction body before being used.</td></tr><tr><td style=3D"padding:0px;vertic=
al-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/driv=
ers/net/zxdh/zxdh_queue.c">zxdh_queue.c (118)</div></td><td style=3D"paddin=
g:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"http=
s://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"paddin=
g:0px;vertical-align:top;width:1457.31px">Expression &#39;queue_type =3D=3D=
 ZXDH_VTNET_TQ&#39; is always true.</td></tr><tr><td style=3D"padding:0px;v=
ertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main=
/drivers/net/zxdh/zxdh_queue.c">zxdh_queue.c (243)</div></td><td style=3D"p=
adding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D=
"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"p=
adding:0px;vertical-align:top;width:1457.31px">Incorrect format. Consider c=
hecking the fifth actual argument of the &#39;rte_log&#39; function. The UN=
SIGNED integer type argument is expected.</td></tr><tr><td style=3D"padding=
:0px;vertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPD=
K/main/drivers/net/zxdh/zxdh_queue.h">zxdh_queue.h (305)</div></td><td styl=
e=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" h=
ref=3D"https://pvs-studio.com/en/docs/warnings/v1048/">V1048</a></td><td st=
yle=3D"padding:0px;vertical-align:top;width:1457.31px">The &#39;vq-&gt;vq_p=
acked.event_flags_shadow&#39; variable was assigned the same value.</td></t=
r><tr><td style=3D"padding:0px;vertical-align:top;width:672.594px"><div tit=
le=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_tables.c">zxdh_table=
s.c (350)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.0=
94px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/=
v519/">V519</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.=
31px">The &#39;ret&#39; variable is assigned values twice successively. Per=
haps this is a mistake. Check lines: 341, 350.</td></tr><tr><td style=3D"pa=
dding:0px;vertical-align:top;width:672.594px"><div title=3D"/home/shemminge=
r/DPDK/main/drivers/net/zxdh/zxdh_tables.c">zxdh_tables.c (58)</div></td><t=
d style=3D"padding:0px;vertical-align:top;width:112.094px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1457.31px">Expression &#39;=
!hw-&gt;is_pf&#39; is always false.</td></tr><tr><td style=3D"padding:0px;v=
ertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main=
/drivers/net/zxdh/zxdh_tables.c">zxdh_tables.c (64)</div></td><td style=3D"=
padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1457.31px">Expression &#39;!port_a=
ttr.rss_enable&#39; is always true.</td></tr><tr><td style=3D"padding:0px;v=
ertical-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main=
/drivers/net/zxdh/zxdh_tables.c">zxdh_tables.c (34)</div></td><td style=3D"=
padding:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1457.31px">The pointer &#39;port_a=
ttr&#39; is cast to a more strictly aligned pointer type.</td></tr><tr><td =
style=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/hom=
e/shemminger/DPDK/main/drivers/net/zxdh/zxdh_tables.c">zxdh_tables.c (98)</=
div></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a ta=
rget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V10=
32</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">The=
 pointer &#39;&amp; port_attr&#39; is cast to a more strictly aligned point=
er type.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672=
.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_tabl=
es.c">zxdh_tables.c (200)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/e=
n/docs/warnings/v1032/">V1032</a></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:1457.31px">The pointer &#39;port_attr&#39; is cast to a more s=
trictly aligned pointer type.</td></tr><tr><td style=3D"padding:0px;vertica=
l-align:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drive=
rs/net/zxdh/zxdh_tables.c">zxdh_tables.c (741)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"htt=
ps://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td style=3D"pad=
ding:0px;vertical-align:top;width:1457.31px">The pointer &#39;&amp; rss_vqi=
d&#39; is cast to a more strictly aligned pointer type.</td></tr><tr><td st=
yle=3D"padding:0px;vertical-align:top;width:672.594px"><div title=3D"/home/=
shemminger/DPDK/main/drivers/net/zxdh/zxdh_tables.c">zxdh_tables.c (765)</d=
iv></td><td style=3D"padding:0px;vertical-align:top;width:112.094px"><a tar=
get=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V103=
2</a></td><td style=3D"padding:0px;vertical-align:top;width:1457.31px">The =
pointer &#39;&amp; rss_vqid&#39; is cast to a more strictly aligned pointer=
 type.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:672.5=
94px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxdh_tables=
.c">zxdh_tables.c (146)</div></td><td style=3D"padding:0px;vertical-align:t=
op;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/=
docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:t=
op;width:1457.31px">Incorrect format. Consider checking the fifth actual ar=
gument of the &#39;rte_log&#39; function. The UNSIGNED integer type argumen=
t is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zxdh/zxd=
h_tables.c">zxdh_tables.c (289)</div></td><td style=3D"padding:0px;vertical=
-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-studio=
.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical=
-align:top;width:1457.31px">Incorrect format. Consider checking the fifth a=
ctual argument of the &#39;rte_log&#39; function. The SIGNED integer type a=
rgument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:t=
op;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/net/zx=
dh/zxdh_tables.c">zxdh_tables.c (324)</div></td><td style=3D"padding:0px;ve=
rtical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ve=
rtical-align:top;width:1457.31px">Incorrect format. Consider checking the f=
ifth actual argument of the &#39;rte_log&#39; function. The SIGNED integer =
type argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:672.594px"><div title=3D"/home/shemminger/DPDK/main/drivers/=
net/zxdh/zxdh_tables.c">zxdh_tables.c (353)</div></td><td style=3D"padding:=
0px;vertical-align:top;width:112.094px"><a target=3D"_blank" href=3D"https:=
//pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:=
0px;vertical-align:top;width:1457.31px">Incorrect format. Consider checking=
 the fifth actual argument of the &#39;rte_log&#39; function. The SIGNED in=
teger type argument is expected.</td></tr></tbody></table></div></div></div=
></div></div>

--00000000000096e99f062e22acb5--
