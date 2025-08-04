Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251CC87FDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 06:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AAD54025D;
	Mon,  4 Aug 2025 08:12:18 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 08355400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 08:12:15 +0200 (CEST)
X-QQ-mid: Yeas10t1754287931t314t55710
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [60.177.96.13])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11106095090377959887
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-3-zaiyuwang@trustnetic.com>
In-Reply-To: <20250626080221.22488-3-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH v3 02/15] net/txgbe: add new SW-FW mailbox interface
Date: Mon, 4 Aug 2025 14:12:10 +0800
Message-ID: <073301dc0506$b694a5d0$23bdf170$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAMcNZ41AnQOYWyymW9icA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OdagxnCWHD+yBwvzJ0h6LguSz/XXHX2w7xUxqC7ew7V7hXaDTbWBhvhX
 ATzktGxVEz41h5CElqRdj4HdM59ucAUDFH5/jXXrx24TreoGii8bWLnT5M5fisDResYTNEp
 7HeY4D7gpDTwQNvqBlK0ZIdgGW24tuWkM6DehAQcKcw8VysAPq0QLzEPE7RSrryGlIeyFed
 Tei6La2gsjtDNfbYCwPuDf2SOVvj5VCSqosGqeLnFAraqQ02mX8SqZND8c/Cnyr359RTgL/
 fzrVBJRogRXPnDVxFhNfvi/wyBYGt8A16EsS4lES0/bIzztO09L7GBJEBuLYb7muhQdXx+Z
 Al3qCxWY7I9C33MlbEZ/fRUasDxTcRz/VBIg7LcIy3g+j/DCDejH5ReW6bsIPDLeoXbxCVc
 /yYrODbfy7lttqvqDtT7unX9byIUWOrmXL75gIGnOF5KpjGN8LbrdnBrCnoMszdUvRRULxH
 mqPnxOgOC81CxDCAVWejqYPN2SYo3tYauqDI/SsgW+4vsRfeyVHcEBSK9S7OaA+/f1qbD0G
 bY/1HohL5E1dDRo/upvQQr7YqBdSsM07dKCCIQ/kUchG2T6TecYITA01Zv2po1PuQ+bjbR9
 fcDooW1I2fhWyDUqExbGJW0SqvAmlo3P8yQYYaYEnkGIDCd5s5gFQ+DK+ojk1FDp4MMBw0L
 XMy2BcAKbj7bnRoJmL+g174/1FvUx2i5Zr8nflZ9YossKb0SsD0vbrKmsZMUuaiV+WOa7Hh
 bIwZ4L+1X0eGFYBGSCLLU8I79d/e+bHcw0of6fW8fYFxGL7p6LugMzLRGcH3EGIDwHqlyVo
 tVOIQhcnF0Q22IMrnX59dAoFBUTLttvrVdDiWQ7LwbQ49As105p8yd2fFhmUjaCpI1VI1Xr
 SdVS2ko7/Q7r2L+IKfi7vyaCaNaKKuMA/IFgjADpzZWG6IzY3i+aUWd0dJvCsh0OyDop/Mf
 hXazeCT3WWCQnA59hD29WsvXcrph4dauaSmWcVktzGgM0r4GU4VlDSd+htTNJaHRHGrA=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

> @@ -113,54 +102,148 @@ txgbe_host_interface_command(struct txgbe_hw *hw, u32 *buffer,
>  {
>  	u32 hdr_size = sizeof(struct txgbe_hic_hdr);
>  	struct txgbe_hic_hdr *resp = (struct txgbe_hic_hdr *)buffer;
> +	struct txgbe_hic_hdr *recv_hdr;
>  	u16 buf_len;
> -	s32 err;
> -	u32 bi;
> +	s32 err = 0;
> +	u32 bi, i;
>  	u32 dword_len;
> +	u8 send_cmd;
> 
>  	if (length == 0 || length > TXGBE_PMMBX_BSIZE) {
>  		DEBUGOUT("Buffer length failure buffersize=%d.", length);
>  		return TXGBE_ERR_HOST_INTERFACE_COMMAND;
>  	}
> 
> -	/* Take management host interface semaphore */
> -	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
> -	if (err)
> -		return err;
> +	/* Calculate length in DWORDs. We must be DWORD aligned */
> +	if (length % sizeof(u32)) {
> +		DEBUGOUT("Buffer length failure, not aligned to dword");
> +		return TXGBE_ERR_INVALID_ARGUMENT;
> +	}
> 
> -	err = txgbe_hic_unlocked(hw, buffer, length, timeout);
> -	if (err)
> -		goto rel_out;
> +	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
> +		/* try to get lock */
> +		while (rte_atomic32_test_and_set(&hw->swfw_busy)) {
> +			timeout--;
> +			if (!timeout)
> +				return TXGBE_ERR_TIMEOUT;
> +			usec_delay(1000);
> +		}
> +
> +		/* index to unique seq id for each mbox message */
> +		resp->cksum_or_index.index = hw->swfw_index;
> +		send_cmd = resp->cmd;
> +
> +		/* Calculate length in DWORDs */
> +		dword_len = length >> 2;
> +
> +		/* write data to SW-FW mbox array */
> +		for (i = 0; i < dword_len; i++) {
> +			wr32a(hw, TXGBE_AML_MNG_MBOX_SW2FW,
> +					i, rte_cpu_to_le_32(buffer[i]));
> +			/* write flush */
> +			rd32a(hw, TXGBE_AML_MNG_MBOX_SW2FW, i);
> +		}
> +
> +		/* amlite: generate interrupt to notify FW */
> +		wr32m(hw, TXGBE_AML_MNG_MBOX_CTL_SW2FW,
> +				  TXGBE_AML_MNG_MBOX_NOTIFY, 0);
> +		wr32m(hw, TXGBE_AML_MNG_MBOX_CTL_SW2FW,
> +				  TXGBE_AML_MNG_MBOX_NOTIFY, TXGBE_AML_MNG_MBOX_NOTIFY);
> +
> +		/* Calculate length in DWORDs */
> +		dword_len = hdr_size >> 2;
> +
> +		/* polling reply from FW */
> +		timeout = 50;
> +		do {
> +			timeout--;
> +			usec_delay(1000);
> +
> +			/* read hdr */
> +			for (bi = 0; bi < dword_len; bi++)
> +				buffer[bi] = rd32a(hw, TXGBE_AML_MNG_MBOX_FW2SW, bi);
> +
> +			/* check hdr */
> +			recv_hdr = (struct txgbe_hic_hdr *)buffer;
> +
> +			if (recv_hdr->cmd == send_cmd &&
> +			    recv_hdr->cksum_or_index.index == hw->swfw_index)
> +				break;
> +		} while (timeout);
> +
> +		if (!timeout) {
> +			PMD_DRV_LOG(ERR, "Polling from FW messages timeout, cmd is 0x%x, index is %d",
> +				send_cmd, hw->swfw_index);
> +			err = TXGBE_ERR_TIMEOUT;
> +			goto rel_out;
> +		}
> +
> +		/* expect no reply from FW then return */
> +		/* release lock if return */
> +		if (!return_data)
> +			goto rel_out;
> +
> +		/* If there is any thing in data position pull it in */
> +		buf_len = recv_hdr->buf_len;
> +		if (buf_len == 0)
> +			goto rel_out;
> +
> +		if (length < buf_len + hdr_size) {
> +			DEBUGOUT("Buffer not large enough for reply message.");
> +			err = TXGBE_ERR_HOST_INTERFACE_COMMAND;
> +			goto rel_out;
> +		}
> 
> -	if (!return_data)
> -		goto rel_out;
> +		/* Calculate length in DWORDs, add 3 for odd lengths */
> +		dword_len = (buf_len + 3) >> 2;
> +		for (; bi <= dword_len; bi++)
> +			buffer[bi] = rd32a(hw, TXGBE_AML_MNG_MBOX_FW2SW, bi);
> +	} else {
> +		/* Take management host interface semaphore */
> +		err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
> +		if (err)
> +			return err;
> 
> -	/* Calculate length in DWORDs */
> -	dword_len = hdr_size >> 2;
> +		err = txgbe_hic_unlocked(hw, buffer, length, timeout);
> +		if (err)
> +			goto rel_out;
> 
> -	/* first pull in the header so we know the buffer length */
> -	for (bi = 0; bi < dword_len; bi++)
> -		buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
> +		if (!return_data)
> +			goto rel_out;
> 
> -	buf_len = resp->buf_len;
> -	if (!buf_len)
> -		goto rel_out;
> +		/* Calculate length in DWORDs */
> +		dword_len = hdr_size >> 2;
> 
> -	if (length < buf_len + hdr_size) {
> -		DEBUGOUT("Buffer not large enough for reply message.");
> -		err = TXGBE_ERR_HOST_INTERFACE_COMMAND;
> -		goto rel_out;
> -	}
> +		/* first pull in the header so we know the buffer length */
> +		for (bi = 0; bi < dword_len; bi++)
> +			buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
> +
> +		buf_len = resp->buf_len;
> +		if (!buf_len)
> +			goto rel_out;
> 
> -	/* Calculate length in DWORDs, add 3 for odd lengths */
> -	dword_len = (buf_len + 3) >> 2;
> +		if (length < buf_len + hdr_size) {
> +			DEBUGOUT("Buffer not large enough for reply message.");
> +			err = TXGBE_ERR_HOST_INTERFACE_COMMAND;
> +			goto rel_out;
> +		}
> 
> -	/* Pull in the rest of the buffer (bi is where we left off) */
> -	for (; bi <= dword_len; bi++)
> -		buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
> +		/* Calculate length in DWORDs, add 3 for odd lengths */
> +		dword_len = (buf_len + 3) >> 2;
> 
> +		/* Pull in the rest of the buffer (bi is where we left off) */
> +		for (; bi <= dword_len; bi++)
> +			buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
> +	}
>  rel_out:
> -	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
> +	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
> +		/* index++, index replace txgbe_hic_hdr.checksum */
> +		hw->swfw_index = resp->cksum_or_index.index == TXGBE_HIC_HDR_INDEX_MAX ?
> +					  0 : resp->cksum_or_index.index + 1;
> +		rte_atomic32_clear(&hw->swfw_busy);
> +	} else {
> +		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
> +	}
> 
>  	return err;
>  }

It would be more appropriate to divide then into two functions with
different mac type, as their contents differ greatly.

> @@ -187,22 +276,27 @@ s32 txgbe_hic_sr_read(struct txgbe_hw *hw, u32 addr, u8 *buf, int len)
>  	command.hdr.req.cmd = FW_READ_SHADOW_RAM_CMD;
>  	command.hdr.req.buf_lenh = 0;
>  	command.hdr.req.buf_lenl = FW_READ_SHADOW_RAM_LEN;
> -	command.hdr.req.checksum = FW_DEFAULT_CHECKSUM;
>  	command.address = cpu_to_be32(addr);
>  	command.length = cpu_to_be16(len);
> +	if (hw->mac.type == txgbe_mac_raptor)
> +		command.hdr.req.cksum_or_index.checksum = FW_DEFAULT_CHECKSUM;

This change is unnecessary:

> @@ -68,21 +70,30 @@ struct txgbe_hic_hdr {
>  		u8 cmd_resv;
>  		u8 ret_status;
>  	} cmd_or_resp;
> -	u8 checksum;
> +	union {
> +		u8 checksum;
> +		u8 index;
> +	} cksum_or_index;
>  };
> 
>  struct txgbe_hic_hdr2_req {
>  	u8 cmd;
>  	u8 buf_lenh;
>  	u8 buf_lenl;
> -	u8 checksum;
> +	union {
> +		u8 checksum;
> +		u8 index;
> +	} cksum_or_index;
>  };
> 
>  struct txgbe_hic_hdr2_rsp {
>  	u8 cmd;
>  	u8 buf_lenl;
>  	u8 buf_lenh_status;     /* 7-5: high bits of buf_len, 4-0: status */
> -	u8 checksum;
> +	union {
> +		u8 checksum;
> +		u8 index;
> +	} cksum_or_index;
>  };

No need to name the union.
 

