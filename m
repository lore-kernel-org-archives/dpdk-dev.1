Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05373606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C09DA40431;
	Tue, 27 Oct 2026 12:45:31 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTPS id 2E9CB400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 12:45:28 +0100 (CET)
X-QQ-mid: tivesync8t1793101520t3d1f3fa8
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.227.112.25])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 16549329367339213064
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>	<D4A752590839CFE3+20261026122638.9198-1-zaiyuwang@trustnetic.com>
 <20261026092856.23d9d925@phoenix.local>
In-Reply-To: <20261026092856.23d9d925@phoenix.local>
Subject: RE: [PATCH v11 00/17] Wangxun fixes and new features
Date: Tue, 27 Oct 2026 19:45:27 +0800
Message-ID: <00cc01dd6608$a9726180$fc572480$@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ8QNehdnXO5ExpIOsSsHb9Qgxp5wLUrKF/APWxMUm1tTCcgA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OXqP5sAKoRxcNFpwC8AEV9xgg+mRCwD/nYbIuWzO52JbER/dqd0RLCfb
 YWPP6r9yeBC6nH7gJigaCES0c6vQxA7s8u6u06TGFDJvPMtbAXKWX/q21XT8yLkdmJ5tZ0g
 e7B94L9nK/TG/qCxMFnLdxcCs0gkSJmh/ALqKvIhrBFSYO9Jn+u16AG176O4uTxHr9pUvnO
 LQhBVDAXvLj2YwsxzmjRAbmGoTsp6oWq6pr2bLddchgfezKl0vwLO0Td23S0SIQBWz1VmxY
 42zMwWeeIqG0TPKB11qzf+eFRcKFfgD398j/McdMIGGxQwVKzJLWH6A1DDLJrXiJIbmFh9d
 xMXiOHTj6O6NTMo9rhx1/sl+CfXWKwsEAqiZw7t7AnKzCZDvQA9gjpsYKanzsFh/sFeaWXR
 yN+Xmbrcn4ZzPV61qRejpem35rJz1+FqkRVS4i8K0s14tr56faEp5zKLCP6Fykd0mjIFFlW
 mOdaKUDOrp2mJMNoFgk2AXRWVRYFLXO5m/9SHWjlyS/vc2V+db9Ub8SApxuf5/q607gByg/
 /n6UWY2pzJLg+SdYaAF8nQFShqvMv7hP7sUMWL3dS9fYFSLewWOb6fvqOXfrNbnjx1eJjHd
 G6PvjbLoMxbZgHKlgVPcImcG1uiCfgDskHzkl5iVE8VAxWi9dcCtyPr4qN9b5T92hvi8rb2
 hVmFRk6RTwcM1GHFzFXufg1fWdHym6pjsZ6XB1pzyKXjv2OyLZdDqTYlxaFvL1Jhojx8cfV
 FNI5KWMEyuErMClrK1VVoS30DddWipPaExxoCU2y8FILxaOG37abtHWSDFGSalM3gE4+giV
 5S4zAb76bV5mSSXhlB5Dl9IX7yp931JN1zrkPWM3J7zFDwctRDtdLDOHSCtDtum6JCa7qXE
 S8uMhw5BU0cU9QkeWWKeAEW3QO7FKFTyj34zbVkvFpEQ+Hhg8aidExtXa0i++08O+U3s5pY
 IkZAMD+spNWw40arbTKe+IHiwe2uxlxtEjX94ziNXNrHHrB3taQLsuR9aUs/sMpBwlIvJqP
 PxX7qedWWAzDv4u7BeA7bqS/qQwqt9l683dRJ/FP1FNBSmwoQW1EKankB8UKvWTwJiiwpw0
 NTkuszqwoNT9pB7/16UflFCbk/Eh/eOdJ6pnOQVsfsI1MJ8zXqnc2Hqo92LiQqZ0Q==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephen,

Thanks for your review. I have addressed these issues and just sent
out v12 series.

> > Patch 13/17 (net/txgbe: fix Tx laser left on at AML40 link down)
> 
> enable_tx_laser() still takes the SWFW semaphore and does an I2C write on AML40:
> 
> 		    hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY) == 0) {
> 			hw->phy.write_i2c_eeprom(hw,
> 				TXGBE_SFF_8636_TX_DISABLE, 0x0);
> 
> and txgbe_set_link_to_amlite() still calls enable_tx_laser() on the TXGBE_ERR_PHY_INIT_NOT_DONE path, under the phy_lock spinlock
taken in
> txgbe_setup_phy_link_aml40().
> 
> It is worse than a long hold. txgbe_dev_setup_link_alarm_handler_aml()
> acquires hw->phy.phy_semaphore_mask before calling setup_link(), and
> txgbe_read_phy_if() sets that mask to TXGBE_MNGSEM_SWPHY. The nested acquire therefore cannot succeed. It spins 200 x 5 ms holding
> phy_lock, then the timeout path in txgbe_acquire_swfw_sync() clears the SW bit the outer caller still holds, so the rest of that
handler runs
> without the semaphore and its final release drops a lock it no longer owns.

You are right about the nested acquire. The call that triggers it is the
one in the PHY init failure path of txgbe_set_link_to_amlite(), which
runs with the PHY lock held and after the alarm handler already took the
semaphore.
The laser is switched there because of what the function does on the peer:
before the local side configures the PHY, the transmitter is switched off and
then switched back on, so that the peer sees an interruption and notices that
it has to re-establish its side against the new configuration.
On the 40G MAC that is not done. The disable before the PHY reset and the
enable on the success path are both limited to the 25G MAC. This was an
oversight: a configuration intended only for the 25G MAC was applied to the
40G MAC. Therefore, I simply added the restriction that limits it to the 25G
MAC.

> Patch 14/17: still busy-waits up to 200 ms (page exchange) and 400 ms
> (CL72) with usec_delay() on the EAL alarm thread.

The issue is confirmed, but changing this here is complicated. For the current
version, I prefer not to make further changes for now. 
A later change will decouple negotiation from the alarm callback and run
per-port negotiations in parallel. That change is still being tested.

> Patch 17/17: a field rename is not a fix, and 234ce0d1fa9d is not in 25.11, so there is nothing to backport. Drop Fixes: and Cc:
stable.

234ce0d1fa was picked into 25.11.3, and the field is present in 25.11.3 and
25.11.4. So the rename does have a backport target.
This is not just a rename. It fixes an obvious spelling error. I checked the
commit history, and fixes for spelling errors are indeed tagged with 'Fixes:',
for example aecba37874 ("net/idpf: fix typo in CQ scan threshold macro
name") so I kept these tags.

Thanks,
Zaiyu Wang
 

