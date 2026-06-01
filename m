Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89803CD6E57
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD75640662;
	Mon,  1 Jun 2026 17:44:16 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id A2C234025F;
 Mon,  1 Jun 2026 17:44:15 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EDAA87A0591;
 Mon,  1 Jun 2026 11:44:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 11:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780328654;
 x=1780415054; bh=HywO15kcjgneGUqcJLX9/6iJSa0ZA+tuKDXioKhca5I=; b=
 h+0JPNyNq9zVMRJ6WcDgERmk4Bjf8uch0x9Xotrs1NkNdsJreNCUl27Qo8v3mOF3
 DyVcBRdAqFPTviNWB6HupsP+T6imaulgWeuEwjDj5cxfvoKd9MdvbpY6O8AUG+UK
 z59jnr/DA0rvXvLRz27wHBDlYHByzS5lwgDvWGQWeIhydVUnfVPtS0eh5AxfweU6
 FMX+rPNJpRjT1lFpQBjq1LmyQ09+YtjJb7b+uRNAjZmzwOABvrqFfH2MqSgxfdEz
 5fO+p7zEpdzzQMu8r9VCiN+KhURawHnAjgsd8i2UQ48Z/MhiP/FZiQdGQPv/ILUo
 IMFHoSEDD7qZdMhl7K1WBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780328654; x=
 1780415054; bh=HywO15kcjgneGUqcJLX9/6iJSa0ZA+tuKDXioKhca5I=; b=C
 eCGtf/udUAK7jlfRHbFxSsxWJLo+y+eHjZKTEGMWQrsKGqbNORpaaTujqxJDY9xH
 XUyF+09oxuNQXG2Bj9YzHWg9PNvAR0i6uNXYqUEyNEEO+9qkpdXnu+F1C+3geNPh
 x8m3XpDR5T5Oh/I+rpqhKbGxAeKnxVVBhCbP/q+rHH/Z1Y5Nc9tauEcmtU3ANhFF
 X7BuPaHwofUSL3LFOm7HZUFFMGieoaIokwU6gVtKLLItuXJW+bOtCU4KQr7OiJnL
 LZLWNjnDMqcz70tZPY9VUOIkVrCxgGP1eu/z/V+BpkcgDuJFAecUtDHrTjCU1FjW
 BF5CwkEvsFNGdnx1WPz0w==
X-ME-Sender: <xms:zqgdav7XXyTWUFU89CnGmmw1ZiVd0PWrTMSC89jTHCk5TWZ3TkhDIA>
 <xme:zqgdav1JNYrCtZeoTNS9kxbj100bgLR4bp9i3cYGuesFRJx1Wss3uk0uhACN87dYy
 wxUt7ZoryWEbrzlsPcPfp0JXW7XrCo553QkhxDWsxeGAtqprWCs>
X-ME-Received: <xmr:zqgdaldFbmLwu3L6GzTcitY-Xh3NhVTRsAKtd8vHGnCMgq2GmcmBLO2L0WzYm9vzfmMckEMpynhd7FRdizfGXKLkWA>
X-ME-Proxy-Cause: dmFkZTFEHe5DnKX4b0NFoLP4J3IemEgMFQZBCLKGvUmvnHehfsbTr/13SetVtiV5D1T03c
 fZEma0DCo/OCxo/nkesKhTjxIT12Xtr3ub5RQKUDHOs59EW/xJ4/W3GA8v4KXwXAu4Bvfz
 qqvEzLvyizFeiPXzbz7WJa2jmW91Fc2aMG75Yp4VD3g+Hca7EAIHqfWyurtCE5TMRNWYHz
 r9IlDgWkXQevIfK7Tueeb+RFj4WN9qNh/nOzpQqbMjKun7gcDkYowZTNB/oB03pWGKipBz
 YuoXvmGF1XF1XghSfC4PQQNOqKq5f88lqHzXhwJjmyxXwVtF2WamWEU8XO3OsJdPnAqAVC
 msJHedN9q/2122HNqdBO3GWty5w0zzE4QzmxM5aryoXQxOtd46gjcOlsz9sd1Y7LuEbZIP
 grwMif7K71TnFiKyHfUr82zQgKqFZ7CWyft4f+8yDOGDT2iAtcwGdX6CRNrVUnwGCORx8u
 xV9bHUdXdUQyFjiTRkugcp+KepY15C0TKlnOv16ycZXrFfEVvPTr1YNLcy3T+NiDXsAwo8
 lIrKk34c0kHWUpr87eJRasRsW8SnKON0MBdRabn4vNm3BdQJmK0u7VGLKNbsZFi+N1Vj0c
 46YK81jmr49CIY6+NHi0if1+PzmI8Pjt1e8HMf45DmBJfCWzDT7HTeVFKFCA
X-ME-Proxy: <xmx:zqgdale0QVgmZUYBNMDFt-ESbgVStxsRYJV_OUkMGdXAGm1c0vHBIA>
 <xmx:zqgdagzPdzlqGa6ecu7zt74AW2KWJGLD-YxyUbcHWbRFiov5kWJpUA>
 <xmx:zqgdak9ex_Fn5E9A5AzZCTm96eyaVbh7MzJy2YO8SRSDWCMNKq86KQ>
 <xmx:zqgdagj2JssKIzxLnP8eO6wMajhsLJIsLV0UHxhKuer0E0FlLEyYTw>
 <xmx:zqgdaqcNaAiHQ_mqE_WeElaD34ZH-V2y5cSqOiAUrOTUR1kpKpJ0Dncz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 11:44:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Zhiguang Jin <jinzhiguang@kylinos.cn>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH v4] ring: fix zero-copy burst API documentation
Date: Mon, 01 Jun 2026 17:44:11 +0200
Message-ID: <5gQNgK-fQ_ijZjH4yK5o7g@monjalon.net>
In-Reply-To: <20260521030009.23491-1-jinzhiguang@kylinos.cn>
References: <20260519133853.889-1-jinzhiguang@kylinos.cn>
 <20260521030009.23491-1-jinzhiguang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

21/05/2026 05:00, Zhiguang Jin:
> These are burst APIs relying on RTE_RING_QUEUE_VARIABLE behavior, they
> operate on a best-effort basis and return the actual number of
> objects processed (between 0 and n).
> 
> Update description to match implementation.
> 
> Fixes: 47bec9a5ca9f ("ring: add zero copy API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhiguang Jin <jinzhiguang@kylinos.cn>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



